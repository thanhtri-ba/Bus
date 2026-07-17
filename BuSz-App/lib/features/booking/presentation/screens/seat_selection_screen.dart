import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';

enum SeatStatus { available, selected, booked, vip, blocked }

class SeatData {
  final String id;
  final String label;
  final SeatStatus status;
  final int price;

  const SeatData({
    required this.id,
    required this.label,
    this.status = SeatStatus.available,
    this.price = 280000,
  });

  SeatData copyWith({SeatStatus? status}) => SeatData(
    id: id,
    label: label,
    status: status ?? this.status,
    price: price,
  );
}

class SeatSelectionScreen extends StatefulWidget {
  final String tripId;
  const SeatSelectionScreen({super.key, required this.tripId});
  @override
  State<SeatSelectionScreen> createState() => _SeatSelectionScreenState();
}

class _SeatSelectionScreenState extends State<SeatSelectionScreen>
    with TickerProviderStateMixin {
  late List<List<SeatData?>> _lowerDeckMap;
  late List<List<SeatData?>> _upperDeckMap;

  final Set<String> _selectedSeats = {};
  late final TabController _tabController;
  bool _isLoadingSeats = true;
  Set<String> _bookedSeats = {};

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _initSeatMap(); // Khởi tạo tạm
    _fetchBookedSeats(); // Tải dữ liệu thực tế chống trùng ghế
  }

  Future<void> _fetchBookedSeats() async {
    try {
      final response = await Supabase.instance.client
          .from('Seat')
          .select('seatNumber, status')
          .eq('tripScheduleId', widget.tripId)
          .inFilter('status', ['BOOKED', 'LOCKED']);

      final booked = <String>{};
      for (var row in response) {
        if (row['seatNumber'] != null) {
          booked.add(row['seatNumber'].toString());
        }
      }

      if (mounted) {
        setState(() {
          _bookedSeats = booked;
          _initSeatMap(); // Update the map with real booked seats
          _isLoadingSeats = false;
        });
      }
    } catch (e) {
      debugPrint('Seat fetch error (Fallback to empty): $e');
      if (mounted) {
        setState(() {
          _initSeatMap();
          _isLoadingSeats = false;
        });
      }
    }
  }

  void _initSeatMap() {
    _lowerDeckMap = _generateDeckMap('A', isVIP: true);
    _upperDeckMap = _generateDeckMap('B', isVIP: false);
  }

  List<List<SeatData?>> _generateDeckMap(
    String deckPrefix, {
    bool isVIP = false,
  }) {
    return List.generate(6, (row) {
      return [
        _createSeat(deckPrefix, row, 'A', isVIP && row < 2),
        null, // Aisle 1
        _createSeat(deckPrefix, row, 'B', isVIP && row < 2),
        null, // Aisle 2
        _createSeat(deckPrefix, row, 'C', isVIP && row < 2),
      ];
    });
  }

  SeatData _createSeat(String deckPrefix, int row, String col, bool isVIP) {
    String label = '$deckPrefix${row + 1}$col';
    bool isBooked = _bookedSeats.contains(label);
    return SeatData(
      id: label,
      label: label,
      status: isBooked
          ? SeatStatus.booked
          : (isVIP ? SeatStatus.vip : SeatStatus.available),
      price: isVIP ? 350000 : 280000,
    );
  }

  void _toggleSeat(SeatData seat, int row, int col, bool isLower) {
    if (seat.status == SeatStatus.booked || seat.status == SeatStatus.blocked) {
      return;
    }

    setState(() {
      if (_selectedSeats.contains(seat.id)) {
        _selectedSeats.remove(seat.id);
        final newSeat = seat.copyWith(
          status: seat.price >= 350000 ? SeatStatus.vip : SeatStatus.available,
        );
        if (isLower) {
          _lowerDeckMap[row][col] = newSeat;
        } else {
          _upperDeckMap[row][col] = newSeat;
        }
      } else {
        if (_selectedSeats.length >= 10) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Tối đa 10 giường mỗi đơn')),
          );
          return;
        }
        _selectedSeats.add(seat.id);
        final newSeat = seat.copyWith(status: SeatStatus.selected);
        if (isLower) {
          _lowerDeckMap[row][col] = newSeat;
        } else {
          _upperDeckMap[row][col] = newSeat;
        }
      }
    });
  }

  int get _totalPrice {
    int total = 0;
    for (final row in _lowerDeckMap) {
      for (final seat in row) {
        if (seat != null && _selectedSeats.contains(seat.id))
          total += seat.price;
      }
    }
    for (final row in _upperDeckMap) {
      for (final seat in row) {
        if (seat != null && _selectedSeats.contains(seat.id))
          total += seat.price;
      }
    }
    return total;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: const Text('Chọn giường'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          tabs: const [
            Tab(text: 'Tầng Dưới'),
            Tab(text: 'Tầng Trên'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Trip info banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            color: AppColors.primaryLight,
            child: Row(
              children: [
                const Icon(
                  Symbols.directions_bus_rounded,
                  color: AppColors.primary,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  'HCM',
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Icon(
                    Symbols.arrow_forward_rounded,
                    size: 16,
                    color: AppColors.primary,
                  ),
                ),
                Text(
                  'Đà Lạt',
                  style: AppTextStyles.label.copyWith(color: AppColors.primary),
                ),
                const Spacer(),
                Text(
                  '06:00 - 13:30',
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildLegend(AppColors.seatAvailable, 'Trống'),
                _buildLegend(AppColors.seatSelected, 'Đang chọn'),
                _buildLegend(AppColors.seatBooked, 'Đã đặt'),
                _buildLegend(AppColors.seatVIP, 'VIP'),
              ],
            ),
          ),

          const Divider(height: 1),

          // Seat Map
          Expanded(
            child: _isLoadingSeats
                ? const Center(child: CircularProgressIndicator())
                : TabBarView(
                    controller: _tabController,
                    children: [
                      _buildDeckMap(_lowerDeckMap, true),
                      _buildDeckMap(_upperDeckMap, false),
                    ],
                  ),
          ),
        ],
      ),

      // Bottom Action Bar
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${_selectedSeats.length} giường đã chọn',
                      style: AppTextStyles.caption,
                    ),
                    Text(
                      '${_formatPrice(_totalPrice)}đ',
                      style: AppTextStyles.titleLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: ElevatedButton(
                  onPressed: _selectedSeats.isEmpty
                      ? null
                      : () {
                          // Save selected seats to provider with proper pricing
                          final selectedSeatData = <SeatData>[];
                          for (final row in _lowerDeckMap) {
                            for (final seat in row) {
                              if (seat != null &&
                                  _selectedSeats.contains(seat.id)) {
                                selectedSeatData.add(seat);
                              }
                            }
                          }
                          for (final row in _upperDeckMap) {
                            for (final seat in row) {
                              if (seat != null &&
                                  _selectedSeats.contains(seat.id)) {
                                selectedSeatData.add(seat);
                              }
                            }
                          }
                          final booking = context.read<BookingProvider>();
                          // Only clear seats, do NOT reset the trip
                          booking.clearSeats();
                          for (final seat in selectedSeatData) {
                            booking.toggleSeat(seat.label, price: seat.price);
                          }
                          context.push(RouteNames.passengerInfo);
                        },
                  child: const Text('Tiếp tục'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDeckMap(List<List<SeatData?>> deckMap, bool isLower) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        children: [
          // Driver icon (Only show for lower deck conceptually)
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.only(left: 32),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: AppRadius.smallAll,
              ),
              child: const Icon(
                Symbols.airline_seat_recline_extra_rounded,
                size: 24,
                color: AppColors.gray500,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Seat grid
          ...List.generate(deckMap.length, (row) {
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.lg),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(deckMap[row].length, (col) {
                  final seat = deckMap[row][col];
                  if (seat == null) {
                    return const SizedBox(width: 32); // Aisle
                  }
                  return _buildSleeperBed(seat, row, col, isLower);
                }),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildSleeperBed(SeatData seat, int row, int col, bool isLower) {
    Color bedColor;
    Color borderColor;
    Color textColor;

    switch (seat.status) {
      case SeatStatus.available:
        bedColor = AppColors.white;
        borderColor = AppColors.borderLight;
        textColor = AppColors.textPrimary;
        break;
      case SeatStatus.selected:
        bedColor = AppColors.seatSelected;
        borderColor = AppColors.seatSelected;
        textColor = AppColors.white;
        break;
      case SeatStatus.booked:
        bedColor = AppColors.seatBooked;
        borderColor = AppColors.seatBooked;
        textColor = AppColors.white;
        break;
      case SeatStatus.vip:
        bedColor = AppColors.seatVIP.withValues(alpha: 0.1);
        borderColor = AppColors.seatVIP;
        textColor = AppColors.seatVIP;
        break;
      case SeatStatus.blocked:
        bedColor = AppColors.seatBlocked;
        borderColor = AppColors.borderLight;
        textColor = AppColors.white;
        break;
    }

    return GestureDetector(
      onTap: () => _toggleSeat(seat, row, col, isLower),
      child: Container(
        width: 60,
        height: 100,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: bedColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: borderColor,
            width: seat.status == SeatStatus.selected ? 2 : 1,
          ),
          boxShadow: [
            if (seat.status == SeatStatus.selected ||
                seat.status == SeatStatus.vip)
              BoxShadow(
                color: borderColor.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
          ],
        ),
        child: Column(
          children: [
            // Pillow
            Container(
              margin: const EdgeInsets.only(top: 8),
              width: 36,
              height: 16,
              decoration: BoxDecoration(
                color:
                    seat.status == SeatStatus.selected ||
                        seat.status == SeatStatus.booked
                    ? Colors.white.withValues(alpha: 0.3)
                    : AppColors.gray200,
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            const Spacer(),
            // Label
            Text(
              seat.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            const Spacer(),
            // Blanket/Footrest pattern
            Container(
              width: double.infinity,
              height: 24,
              decoration: BoxDecoration(
                color:
                    seat.status == SeatStatus.selected ||
                        seat.status == SeatStatus.booked
                    ? Colors.white.withValues(alpha: 0.15)
                    : (seat.status == SeatStatus.vip
                          ? AppColors.seatVIP.withValues(alpha: 0.2)
                          : AppColors.gray50),
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(11),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegend(Color color, String label) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color.withValues(
              alpha: color == AppColors.seatVIP ? 0.3 : 1,
            ),
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: color == AppColors.white
                  ? AppColors.borderLight
                  : Colors.transparent,
            ),
          ),
        ),
        const SizedBox(width: 4),
        Text(label, style: AppTextStyles.captionSmall),
      ],
    );
  }

  String _formatPrice(int price) {
    return price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (match) => '${match[1]}.',
    );
  }
}
