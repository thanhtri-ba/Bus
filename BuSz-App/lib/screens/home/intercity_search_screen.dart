/// BusZ — Search Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/06_Search_Module.md
///
/// Implements: Search Form, Station Autocomplete (via navigation),
/// Search History, and Favorite Routes.
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';

class IntercitySearchScreen extends StatefulWidget {
  const IntercitySearchScreen({super.key});

  @override
  State<IntercitySearchScreen> createState() => _IntercitySearchScreenState();
}

class _IntercitySearchScreenState extends State<IntercitySearchScreen> {
  String _departure = 'TP. Hồ Chí Minh';
  String _arrival = 'Đà Lạt';
  final String _date = 'Hôm nay, 05/07';
  final int _passengers = 1;

  void _swapStations() {
    setState(() {
      final temp = _departure;
      _departure = _arrival;
      _arrival = temp;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tìm kiếm chuyến xe'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Search Form ──────────────────────────────────────────
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              color: AppColors.white,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push(RouteNames.searchCity),
                          child: _buildInputBox('Điểm đi', _departure),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryLight,
                          shape: BoxShape.circle,
                        ),
                        child: IconButton(
                          icon: const Icon(
                            Symbols.swap_horiz_rounded,
                            color: AppColors.primary,
                          ),
                          onPressed: _swapStations,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: GestureDetector(
                          onTap: () => context.push(
                            '${RouteNames.searchCity}?destination=true',
                          ),
                          child: _buildInputBox('Điểm đến', _arrival),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(
                        child: _buildIconInputBox(
                          Symbols.calendar_today_rounded,
                          'Ngày đi',
                          _date,
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Expanded(
                        child: _buildIconInputBox(
                          Symbols.person_rounded,
                          'Hành khách',
                          '$_passengers Người',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        final booking = context.read<BookingProvider>();
                        booking.setSearch(
                          departure: _departure,
                          destination: _arrival,
                          date: _date,
                          passengerCount: _passengers,
                        );
                        context.push(RouteNames.searchResults);
                      },
                      child: const Text('Tìm Chuyến Xe'),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1, color: AppColors.gray200),

            // ─── Search History ───────────────────────────────────────
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Tìm kiếm gần đây', style: AppTextStyles.titleSmall),
                  Text(
                    'Xóa',
                    style: AppTextStyles.captionSmall.copyWith(
                      color: AppColors.error,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                children: [
                  _buildHistoryCard(
                    'HCM',
                    'Nha Trang',
                    'Ngày 10/07',
                    '1 Người',
                  ),
                  _buildHistoryCard('HCM', 'Đà Lạt', 'Ngày 15/07', '2 Người'),
                  _buildHistoryCard('Đà Nẵng', 'Huế', 'Ngày 20/07', '1 Người'),
                ],
              ),
            ),

            // ─── Favorite Routes ──────────────────────────────────────
            const SizedBox(height: AppSpacing.xl),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              child: Text(
                'Tuyến đường yêu thích',
                style: AppTextStyles.titleSmall,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            ListView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              children: [
                _buildFavoriteRoute('TP. Hồ Chí Minh', 'Đà Lạt'),
                _buildFavoriteRoute('TP. Hồ Chí Minh', 'Cần Thơ'),
                _buildFavoriteRoute('Hà Nội', 'Sapa'),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }

  Widget _buildInputBox(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: AppRadius.mediumAll,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.captionSmall),
          const SizedBox(height: 4),
          Text(
            value,
            style: AppTextStyles.label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Widget _buildIconInputBox(IconData icon, String label, String value) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: AppRadius.mediumAll,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Row(
        children: [
          Icon(icon, size: 16, color: AppColors.textSecondary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.captionSmall),
                const SizedBox(height: 2),
                Text(value, style: AppTextStyles.labelSmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryCard(String from, String to, String date, String pax) {
    return GestureDetector(
      onTap: () {
        context.read<BookingProvider>().setSearch(
          departure: from,
          destination: to,
          date: date,
          passengerCount: int.tryParse(pax.split(' ')[0]) ?? 1,
        );
        context.push(RouteNames.searchResults);
      },
      child: Container(
        width: 220,
        margin: const EdgeInsets.only(right: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfaceCard,
          borderRadius: AppRadius.card,
          border: Border.all(color: AppColors.borderLight),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(from, style: AppTextStyles.label),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4),
                  child: Icon(
                    Symbols.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.gray500,
                  ),
                ),
                Text(to, style: AppTextStyles.label),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Text(date, style: AppTextStyles.captionSmall),
                const Text(' • ', style: TextStyle(color: AppColors.gray500)),
                Text(pax, style: AppTextStyles.captionSmall),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFavoriteRoute(String from, String to) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.primaryLight,
          borderRadius: AppRadius.smallAll,
        ),
        child: const Icon(
          Symbols.favorite_rounded,
          color: AppColors.primary,
          size: 20,
        ),
      ),
      title: Row(
        children: [
          Text(from, style: AppTextStyles.label),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Icon(
              Symbols.arrow_forward_rounded,
              size: 14,
              color: AppColors.gray500,
            ),
          ),
          Text(to, style: AppTextStyles.label),
        ],
      ),
      trailing: const Icon(
        Symbols.chevron_right_rounded,
        color: AppColors.gray500,
      ),
      onTap: () {
        context.read<BookingProvider>().setSearch(
          departure: from,
          destination: to,
          date: 'Hôm nay',
          passengerCount: 1,
        );
        context.push(RouteNames.searchResults);
      },
    );
  }
}
