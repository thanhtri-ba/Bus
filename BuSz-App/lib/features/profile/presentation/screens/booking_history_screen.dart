import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/features/profile/presentation/widgets/review_bottom_sheet.dart';

class BookingHistoryScreen extends StatefulWidget {
  const BookingHistoryScreen({super.key});

  @override
  State<BookingHistoryScreen> createState() => _BookingHistoryScreenState();
}

class _BookingHistoryScreenState extends State<BookingHistoryScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
        title: Text('Lịch sử đặt vé', style: AppTextStyles.titleLarge),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Symbols.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.textSecondary,
          indicatorColor: AppColors.primary,
          tabs: const [
            Tab(text: 'Đã hoàn thành'),
            Tab(text: 'Đã hủy'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [_buildCompletedList(), _buildCancelledList()],
      ),
    );
  }

  Widget _buildCompletedList() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _buildHistoryCard('Hà Nội', 'Sapa', 'G5 Bus', 'Hoàn thành', true),
      ],
    );
  }

  Widget _buildCancelledList() {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        _buildHistoryCard(
          'Hồ Chí Minh',
          'Đà Lạt',
          'Phương Trang',
          'Đã hủy',
          false,
        ),
      ],
    );
  }

  Widget _buildHistoryCard(
    String from,
    String to,
    String bus,
    String status,
    bool canReview,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfacePrimary,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('$from - $to', style: AppTextStyles.titleMedium),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: canReview
                      ? AppColors.successLight
                      : AppColors.errorLight,
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  status,
                  style: AppTextStyles.captionSmall.copyWith(
                    color: canReview ? AppColors.success : AppColors.error,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(bus, style: AppTextStyles.bodyMedium),
          if (canReview) ...[
            const Divider(height: 24),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (_) => const ReviewBottomSheet(),
                  );
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.primary),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
                child: const Text('Đánh giá chuyến đi'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
