/// BusZ — Notification Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/11_Notification_Module.md
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông báo'),
        actions: [
          TextButton(onPressed: () {}, child: const Text('Đánh dấu đã đọc')),
        ],
      ),
      body: _buildNotificationList(),
    );
  }

  Widget _buildNotificationList() {
    // For now, returning mock data. Later, use BlocBuilder.
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.md),
      children: [
        Text('Hôm nay', style: AppTextStyles.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        _buildNotificationItem(
          icon: Symbols.confirmation_number_rounded,
          color: AppColors.success,
          title: 'Đặt vé thành công!',
          message: 'Chuyến đi HCM → Đà Lạt ngày 05/07/2026 đã được xác nhận.',
          time: '10:30',
          isUnread: true,
        ),
        _buildNotificationItem(
          icon: Symbols.local_offer_rounded,
          color: AppColors.warning,
          title: 'Khuyến mãi đặc biệt 20%',
          message: 'Nhập mã HÈ2026 để được giảm 20% cho chuyến đi tiếp theo.',
          time: '08:00',
          isUnread: false,
        ),
        const SizedBox(height: AppSpacing.lg),
        Text('Hôm qua', style: AppTextStyles.titleSmall),
        const SizedBox(height: AppSpacing.sm),
        _buildNotificationItem(
          icon: Symbols.account_balance_wallet_rounded,
          color: AppColors.info,
          title: 'Thanh toán thành công',
          message: 'Bạn đã thanh toán 725.000đ qua VNPay.',
          time: '15:20',
          isUnread: false,
        ),
      ],
    );
  }

  Widget _buildNotificationItem({
    required IconData icon,
    required Color color,
    required String title,
    required String message,
    required String time,
    required bool isUnread,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.sm),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: isUnread ? color.withValues(alpha: 0.05) : AppColors.surfaceCard,
        borderRadius: AppRadius.card,
        border: Border.all(
          color: isUnread
              ? color.withValues(alpha: 0.3)
              : AppColors.borderLight,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: AppTextStyles.label.copyWith(
                    fontWeight: isUnread ? FontWeight.bold : FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(message, style: AppTextStyles.bodySmall),
                const SizedBox(height: 4),
                Text(time, style: AppTextStyles.captionSmall),
              ],
            ),
          ),
          if (isUnread)
            Container(
              margin: const EdgeInsets.only(top: 4),
              width: 8,
              height: 8,
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            ),
        ],
      ),
    );
  }
}
