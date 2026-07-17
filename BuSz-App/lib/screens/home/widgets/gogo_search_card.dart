import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:busz/screens/home/widgets/date_picker_bottom_sheet.dart';
import 'package:busz/core/theme/app_colors.dart';

class GogoSearchCard extends StatefulWidget {
  const GogoSearchCard({super.key});

  @override
  State<GogoSearchCard> createState() => _GogoSearchCardState();
}

class _GogoSearchCardState extends State<GogoSearchCard> {
  String _departure = 'Bạn muốn đi từ đâu?';
  String _destination = 'Bạn muốn đến đâu?';
  String _date = 'Thứ 6, 25 Tháng 10, 2024';

  void _swapStations() {
    setState(() {
      final temp = _departure;
      _departure = _destination;
      _destination = temp;
    });
  }

  Future<void> _pickLocation(bool isDestination) async {
    final result = await context.push<String>(
      '${RouteNames.searchCity}${isDestination ? '?destination=true' : ''}',
    );
    if (result != null) {
      setState(() {
        if (isDestination) {
          _destination = result;
        } else {
          _departure = result;
        }
      });
    }
  }

  Future<void> _pickDate() async {
    final result = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const DatePickerBottomSheet(),
    );
    if (result != null) {
      setState(() {
        _date = 'Ngày ${result.day}/${result.month}/${result.year}';
      });
    }
  }

  void _searchTicket() {
    final bool hasValidDeparture = !_departure.contains('đâu');
    final bool hasValidDestination = !_destination.contains('đâu');

    if (!hasValidDeparture || !hasValidDestination) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Vui lòng chọn điểm đi và điểm đến'),
          behavior: SnackBarBehavior.floating,
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    context.read<BookingProvider>().setSearch(
      departure: _departure,
      destination: _destination,
      date: _date,
    );
    context.push(RouteNames.searchResults);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderNormal),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Column(
                children: [
                  GestureDetector(
                    onTap: () => _pickLocation(false),
                    child: _buildInputField(
                      label: 'Điểm đi',
                      value: _departure,
                      icon: Symbols.location_on_rounded,
                      isTop: true,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => _pickLocation(true),
                    child: _buildInputField(
                      label: 'Điểm đến',
                      value: _destination,
                      icon: Symbols.location_on_rounded,
                      isTop: false,
                    ),
                  ),
                ],
              ),
              // Swap Button
              Positioned(
                right: 16,
                top: 46, // Center between the two inputs vertically
                child: GestureDetector(
                  onTap: _swapStations,
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.secondary, // Dark blue
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.secondary.withOpacity(0.2),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Symbols.swap_vert_rounded,
                      color: Colors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          GestureDetector(
            onTap: _pickDate,
            child: _buildInputField(
              label: 'Ngày khởi hành',
              value: _date,
              icon: Symbols.calendar_today_rounded,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            height: 52,
            child: ElevatedButton(
              onPressed: _searchTicket,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFF79009), // Orange from mockup
                foregroundColor: Colors.white,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Tìm chuyến xe',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String value,
    required IconData icon,
    bool? isTop,
  }) {
    final isPlaceholder = value.contains('đâu');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.borderNormal),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(icon, color: AppColors.secondary, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  value,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontWeight: isPlaceholder
                        ? FontWeight.w400
                        : FontWeight.w500,
                    fontSize: 14,
                    color: isPlaceholder
                        ? AppColors.textHint
                        : AppColors.textPrimary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
