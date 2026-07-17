/// BusZ — Search Results Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/06_Search_Module.md
///
/// Implements: Header (Search Params), Filter Bar, Sort Bar, Trip List,
/// and Trip Cards.
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/widgets/loading_skeleton.dart';
import 'package:busz/providers/booking_provider.dart';

import 'package:busz/models/home_models.dart';
import 'package:busz/services/bus_service.dart';

class SearchResultsScreen extends StatefulWidget {
  const SearchResultsScreen({super.key});

  @override
  State<SearchResultsScreen> createState() => _SearchResultsScreenState();
}

class _SearchResultsScreenState extends State<SearchResultsScreen> {
  bool _isLoading = true;
  List<Trip> _allTrips = [];

  String _sortBy = 'price_asc';
  final Set<String> _selectedBusAgents = {};
  final Set<String> _selectedBusClasses = {};

  @override
  void initState() {
    super.initState();
    _fetchTrips();
  }

  Future<void> _fetchTrips() async {
    final booking = context.read<BookingProvider>();
    final request = SearchRequest(
      departureCity: booking.departure,
      arrivalCity: booking.destination,
      date: DateTime.now(), // Real app would parse booking.travelDate
    );

    final results = await BusService.searchBuses(request);

    if (mounted) {
      setState(() {
        _allTrips = results;
        _isLoading = false;
      });
    }
  }

  List<Trip> get _filteredTrips {
    List<Trip> result = _allTrips.where((t) {
      if (_selectedBusAgents.isNotEmpty &&
          !_selectedBusAgents.contains(t.busAgent)) {
        return false;
      }
      if (_selectedBusClasses.isNotEmpty &&
          !_selectedBusClasses.contains(t.busClass)) {
        return false;
      }
      return true;
    }).toList();

    result.sort((a, b) {
      switch (_sortBy) {
        case 'price_asc':
          return a.price.compareTo(b.price);
        case 'price_desc':
          return b.price.compareTo(a.price);
        case 'time_asc':
          return a.departureTime.compareTo(b.departureTime);
        case 'time_desc':
          return b.departureTime.compareTo(a.departureTime);
        default:
          return 0;
      }
    });

    return result;
  }

  String get _sortLabel {
    switch (_sortBy) {
      case 'price_asc':
        return 'Giá thấp nhất';
      case 'price_desc':
        return 'Giá cao nhất';
      case 'time_asc':
        return 'Giờ đi sớm nhất';
      case 'time_desc':
        return 'Giờ đi muộn nhất';
      default:
        return 'Sắp xếp';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Consumer<BookingProvider>(
          builder: (context, booking, _) {
            final from =
                (booking.departure as dynamic) == null ||
                    booking.departure.isEmpty
                ? 'Đi'
                : booking.departure;
            final to =
                (booking.destination as dynamic) == null ||
                    booking.destination.isEmpty
                ? 'Đến'
                : booking.destination;
            final date =
                (booking.travelDate as dynamic) == null ||
                    booking.travelDate.isEmpty
                ? ''
                : booking.travelDate;
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Flexible(
                      child: Text(
                        from,
                        style: AppTextStyles.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Icon(Symbols.arrow_right_alt_rounded, size: 20),
                    ),
                    Flexible(
                      child: Text(
                        to,
                        style: AppTextStyles.titleMedium,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                if (date.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(date, style: AppTextStyles.caption),
                      const Text(
                        ' • ',
                        style: TextStyle(color: AppColors.gray500),
                      ),
                      const Icon(
                        Symbols.person_rounded,
                        color: AppColors.gray500,
                        size: 12,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${booking.passengerCount} Khách',
                        style: AppTextStyles.caption,
                      ),
                    ],
                  ),
                ],
              ],
            );
          },
        ),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Symbols.edit_rounded),
            onPressed: () => context.pop(), // Go back to search screen to edit
          ),
        ],
      ),
      body: Stack(
        children: [
          // Trip List
          ListView(
            padding: const EdgeInsets.only(
              left: AppSpacing.md,
              right: AppSpacing.md,
              top: AppSpacing.md,
              bottom: 100, // Space for floating filter bar
            ),
            children: [
              if (_isLoading) ...[
                const SkeletonList(itemCount: 4),
              ] else if (_filteredTrips.isEmpty) ...[
                const Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Center(
                    child: Text(
                      'Không tìm thấy chuyến xe nào phù hợp.',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: AppColors.gray500),
                    ),
                  ),
                ),
              ] else ...[
                ..._filteredTrips.map(
                  (trip) => _buildTripCard(
                    id: trip.id,
                    company: trip.busAgent,
                    type: trip.busClass,
                    pricePerSeat: trip.price,
                    departureTime: trip.departureTime.substring(
                      0,
                      5,
                    ), // Format HH:mm
                    arrivalTime: trip.arrivalTime.substring(
                      0,
                      5,
                    ), // Format HH:mm
                    duration: trip.duration,
                    departureStation: trip.departureStation,
                    arrivalStation: trip.arrivalStation,
                    seatsLeft: 20, // Mock seats
                    rating: '4.8', // Mock rating
                  ),
                ),
              ],
            ],
          ),

          // Floating Filter/Sort Bar
          Positioned(
            bottom: AppSpacing.xl,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: AppRadius.pillAll,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.15),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFloatingAction(
                        Symbols.filter_alt_rounded,
                        'Lọc',
                        _showFilterSheet,
                      ),
                      Container(width: 1, height: 24, color: AppColors.gray300),
                      _buildFloatingAction(
                        Symbols.swap_vert_rounded,
                        _sortLabel,
                        _showSortSheet,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingAction(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: AppRadius.pillAll,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: AppColors.textPrimary),
            const SizedBox(width: AppSpacing.xs),
            Text(label, style: AppTextStyles.label),
          ],
        ),
      ),
    );
  }

  void _showSortSheet() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Sắp xếp theo',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              _buildSortOption('Giá thấp nhất', 'price_asc'),
              _buildSortOption('Giá cao nhất', 'price_desc'),
              _buildSortOption('Giờ đi sớm nhất', 'time_asc'),
              _buildSortOption('Giờ đi muộn nhất', 'time_desc'),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSortOption(String label, String value) {
    return ListTile(
      title: Text(
        label,
        style: TextStyle(
          fontWeight: _sortBy == value ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      trailing: _sortBy == value
          ? const Icon(Symbols.check_circle_rounded, color: AppColors.primary)
          : null,
      onTap: () {
        setState(() => _sortBy = value);
        Navigator.pop(context);
      },
    );
  }

  void _showFilterSheet() {
    final allAgents = _allTrips.map((e) => e.busAgent).toSet().toList();
    final allClasses = _allTrips.map((e) => e.busClass).toSet().toList();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Bộ lọc',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setModalState(() {
                              _selectedBusAgents.clear();
                              _selectedBusClasses.clear();
                            });
                          },
                          child: const Text('Xóa lọc'),
                        ),
                      ],
                    ),
                    const Divider(),
                    const Text(
                      'Nhà xe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: allAgents.map((agent) {
                        final isSelected = _selectedBusAgents.contains(agent);
                        return FilterChip(
                          label: Text(agent),
                          selected: isSelected,
                          selectedColor: AppColors.primaryLight,
                          checkmarkColor: AppColors.primary,
                          onSelected: (val) {
                            setModalState(() {
                              if (val) {
                                _selectedBusAgents.add(agent);
                              } else {
                                _selectedBusAgents.remove(agent);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Loại xe',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: allClasses.map((cls) {
                        final isSelected = _selectedBusClasses.contains(cls);
                        return FilterChip(
                          label: Text(cls),
                          selected: isSelected,
                          selectedColor: AppColors.primaryLight,
                          checkmarkColor: AppColors.primary,
                          onSelected: (val) {
                            setModalState(() {
                              if (val) {
                                _selectedBusClasses.add(cls);
                              } else {
                                _selectedBusClasses.remove(cls);
                              }
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {});
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Áp dụng',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildTripCard({
    required String id,
    required String company,
    required String type,
    required int pricePerSeat,
    required String departureTime,
    required String arrivalTime,
    required String duration,
    required String departureStation,
    required String arrivalStation,
    required int seatsLeft,
    required String rating,
  }) {
    final isFewSeats = seatsLeft <= 5;
    final formattedPrice = BookingProvider.formatVND(pricePerSeat);

    return GestureDetector(
      onTap: () {
        // Save selected trip to BookingProvider before navigating
        context.read<BookingProvider>().selectTrip(
          SelectedTrip(
            id: id,
            company: company,
            busType: type,
            departureTime: departureTime,
            arrivalTime: arrivalTime,
            duration: duration,
            departureStation: departureStation,
            arrivalStation: arrivalStation,
            basePricePerSeat: pricePerSeat,
          ),
        );
        context.push('/trip/$id');
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Company Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: AppColors.gray100,
                        borderRadius: AppRadius.smallAll,
                      ),
                      child: const Icon(
                        Symbols.directions_bus_rounded,
                        size: 16,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(company, style: AppTextStyles.label),
                        Text(type, style: AppTextStyles.captionSmall),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 6,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.warningLight,
                    borderRadius: AppRadius.smallAll,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Symbols.star_rounded,
                        size: 14,
                        color: AppColors.warning,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        rating,
                        style: AppTextStyles.captionSmall.copyWith(
                          color: AppColors.warning,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: AppSpacing.lg),

            // Route Time
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(departureTime, style: AppTextStyles.titleMedium),
                      const SizedBox(height: 2),
                      Text(departureStation, style: AppTextStyles.caption),
                    ],
                  ),
                ),
                Column(
                  children: [
                    Text(duration, style: AppTextStyles.captionSmall),
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 4),
                      width: 40,
                      height: 1,
                      color: AppColors.gray300,
                    ),
                  ],
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(arrivalTime, style: AppTextStyles.titleMedium),
                      const SizedBox(height: 2),
                      Text(arrivalStation, style: AppTextStyles.caption),
                    ],
                  ),
                ),
              ],
            ),

            const Divider(height: AppSpacing.xl),

            // Footer (Price & Action)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      formattedPrice,
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                    Text(
                      'Còn $seatsLeft chỗ',
                      style: AppTextStyles.captionSmall.copyWith(
                        color: isFewSeats ? AppColors.error : AppColors.success,
                        fontWeight: isFewSeats
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                    context.read<BookingProvider>().selectTrip(
                      SelectedTrip(
                        id: id,
                        company: company,
                        busType: type,
                        departureTime: departureTime,
                        arrivalTime: arrivalTime,
                        duration: duration,
                        departureStation: departureStation,
                        arrivalStation: arrivalStation,
                        basePricePerSeat: pricePerSeat,
                      ),
                    );
                    context.push('/trip/$id/seats');
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(100, 36),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                  ),
                  child: const Text('Chọn ghế'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
