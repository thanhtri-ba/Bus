/// BusZ — Trip Detail Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/07_Booking_Module.md
///                  BusZ-Documentation/01_Business/04_Booking_Process.md §4-5
///
/// Shows full trip information before seat selection:
/// - Bus company info & gallery
/// - Route details (departure → arrival, stops)
/// - Facilities
/// - Policy & Terms
/// - Price
/// - Continue / Select Seats button
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';

class TripDetailScreen extends StatelessWidget {
  final String tripId;

  const TripDetailScreen({super.key, required this.tripId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ── Hero Image Header ─────────────────────────────────
          SliverAppBar(
            expandedHeight: 220,
            pinned: true,
            backgroundColor: AppColors.primary,
            leading: Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white.withValues(alpha: 0.9),
                  borderRadius: AppRadius.mediumAll,
                ),
                child: IconButton(
                  icon: const Icon(
                    Symbols.arrow_back_ios_new_rounded,
                    size: 18,
                    color: AppColors.black,
                  ),
                  onPressed: () => context.pop(),
                ),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: const BoxDecoration(
                  gradient: AppColors.primaryGradient,
                ),
                child: const Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Symbols.directions_bus_rounded,
                        size: 64,
                        color: AppColors.white,
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Bus Gallery',
                        style: TextStyle(color: Colors.white70, fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // ── Trip Content ──────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Bus Company Header
                  Row(
                    children: [
                      Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: AppColors.gray100,
                          borderRadius: AppRadius.mediumAll,
                        ),
                        child: const Icon(
                          Symbols.directions_bus_rounded,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Phương Trang',
                              style: AppTextStyles.titleSmall,
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Giường nằm cao cấp',
                              style: AppTextStyles.bodySmall,
                            ),
                          ],
                        ),
                      ),
                      // Rating
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.warningLight,
                          borderRadius: AppRadius.smallAll,
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Symbols.star_rounded,
                              size: 16,
                              color: AppColors.warning,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '4.5',
                              style: AppTextStyles.labelSmall.copyWith(
                                color: AppColors.warning,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Route Info
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: AppRadius.card,
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Column(
                      children: [
                        _buildRouteRow(
                          time: '06:00',
                          station: 'Bến xe Miền Đông',
                          city: 'TP. Hồ Chí Minh',
                          isStart: true,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 24),
                          child: Row(
                            children: [
                              Container(
                                width: 2,
                                height: 40,
                                color: AppColors.gray300,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Row(
                                children: [
                                  const Icon(
                                    Symbols.access_time_rounded,
                                    size: 14,
                                    color: AppColors.gray500,
                                  ),
                                  const SizedBox(width: 4),
                                  Text('7h 30m', style: AppTextStyles.caption),
                                ],
                              ),
                            ],
                          ),
                        ),
                        _buildRouteRow(
                          time: '13:30',
                          station: 'Bến xe Đà Lạt',
                          city: 'Đà Lạt, Lâm Đồng',
                          isStart: false,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Facilities
                  Text('Tiện ích', style: AppTextStyles.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.xs,
                    runSpacing: AppSpacing.xs,
                    children: [
                      _buildFacilityChip(Symbols.wifi_rounded, 'WiFi'),
                      _buildFacilityChip(Symbols.ac_unit_rounded, 'Điều hòa'),
                      _buildFacilityChip(Symbols.usb_rounded, 'Sạc USB'),
                      _buildFacilityChip(
                        Symbols.water_drop_rounded,
                        'Nước uống',
                      ),
                      _buildFacilityChip(
                        Symbols.airline_seat_flat_rounded,
                        'Giường nằm',
                      ),
                      _buildFacilityChip(Symbols.wc_rounded, 'WC'),
                    ],
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  // Policy
                  Text('Chính sách', style: AppTextStyles.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  _buildPolicyItem(
                    Symbols.cancel_rounded,
                    'Hủy miễn phí trước 24h',
                  ),
                  _buildPolicyItem(
                    Symbols.swap_horiz_rounded,
                    'Đổi vé trước 12h',
                  ),
                  _buildPolicyItem(
                    Symbols.luggage_rounded,
                    'Hành lý tối đa 20kg',
                  ),
                  _buildPolicyItem(Symbols.pets_rounded, 'Không mang thú cưng'),

                  const SizedBox(height: AppSpacing.lg),

                  // Reviews Summary
                  Container(
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: AppRadius.card,
                      border: Border.all(color: AppColors.borderLight),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            Text(
                              '4.5',
                              style: AppTextStyles.displayLarge.copyWith(
                                color: AppColors.warning,
                              ),
                            ),
                            Row(
                              children: List.generate(
                                5,
                                (i) => Icon(
                                  i < 4
                                      ? Symbols.star_rounded
                                      : Symbols.star_half_rounded,
                                  size: 16,
                                  color: AppColors.warning,
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text('128 đánh giá', style: AppTextStyles.caption),
                          ],
                        ),
                        const SizedBox(width: AppSpacing.xl),
                        Expanded(
                          child: Column(
                            children: [
                              _buildRatingBar('5', 0.7),
                              _buildRatingBar('4', 0.2),
                              _buildRatingBar('3', 0.05),
                              _buildRatingBar('2', 0.03),
                              _buildRatingBar('1', 0.02),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 100), // Space for bottom button
                ],
              ),
            ),
          ),
        ],
      ),

      // ── Bottom Action Bar ─────────────────────────────────────
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
                    Text('Giá từ', style: AppTextStyles.caption),
                    Text(
                      '280.000đ',
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
                  onPressed: () => context.push('/trip/$tripId/seats'),
                  child: const Text('Chọn ghế'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRouteRow({
    required String time,
    required String station,
    required String city,
    required bool isStart,
  }) {
    return Row(
      children: [
        Container(
          width: 48,
          alignment: Alignment.center,
          child: Text(time, style: AppTextStyles.titleSmall),
        ),
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: isStart ? AppColors.routeDeparture : AppColors.routeArrival,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(station, style: AppTextStyles.label),
              Text(city, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFacilityChip(IconData icon, String label) {
    return Chip(
      avatar: Icon(icon, size: 16, color: AppColors.primary),
      label: Text(label),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildPolicyItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        children: [
          Icon(icon, size: 20, color: AppColors.gray500),
          const SizedBox(width: AppSpacing.sm),
          Expanded(child: Text(text, style: AppTextStyles.bodyMedium)),
        ],
      ),
    );
  }

  Widget _buildRatingBar(String label, double fraction) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          SizedBox(
            width: 14,
            child: Text(label, style: AppTextStyles.captionSmall),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: ClipRRect(
              borderRadius: AppRadius.pillAll,
              child: LinearProgressIndicator(
                value: fraction,
                backgroundColor: AppColors.gray100,
                valueColor: const AlwaysStoppedAnimation(AppColors.warning),
                minHeight: 6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
