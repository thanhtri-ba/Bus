/// BusZ — Payment Result Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/08_Payment_Module.md §11
///
/// Displays payment outcome:
/// - Success → Navigate to Ticket
/// - Failed → Retry / Choose Another Method
/// - Electronic receipt info
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/router/route_names.dart';

class PaymentResultScreen extends StatelessWidget {
  final bool isSuccess;

  const PaymentResultScreen({super.key, this.isSuccess = true});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),

              // Status Icon
              Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: isSuccess
                      ? AppColors.successLight
                      : AppColors.errorLight,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  isSuccess
                      ? Symbols.check_circle_rounded
                      : Symbols.cancel_rounded,
                  size: 64,
                  color: isSuccess ? AppColors.success : AppColors.error,
                ),
              ),
              const SizedBox(height: AppSpacing.xl),

              // Title
              Text(
                isSuccess ? 'Thanh toán thành công!' : 'Thanh toán thất bại',
                style: AppTextStyles.headline,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                isSuccess
                    ? 'Vé điện tử đã được tạo và gửi đến email của bạn.'
                    : 'Có lỗi xảy ra trong quá trình thanh toán. Vui lòng thử lại.',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),

              if (isSuccess) ...[
                const SizedBox(height: AppSpacing.xxl),

                // Receipt Info
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceCard,
                    borderRadius: AppRadius.card,
                    border: Border.all(color: AppColors.borderLight),
                  ),
                  child: Column(
                    children: [
                      _buildReceiptRow('Mã giao dịch', 'TXN-2026070500123'),
                      _buildReceiptRow('Mã đặt vé', 'BK-ABC123'),
                      _buildReceiptRow('Số tiền', '725.000đ'),
                      _buildReceiptRow('Phương thức', 'VNPay'),
                      _buildReceiptRow('Thời gian', '05/07/2026 06:15'),
                    ],
                  ),
                ),
              ],

              const Spacer(),

              // Action Buttons
              if (isSuccess) ...[
                ElevatedButton.icon(
                  onPressed: () => context.go(RouteNames.bookings),
                  icon: const Icon(Symbols.confirmation_number_rounded),
                  label: const Text('Xem vé'),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () => context.go(RouteNames.home),
                  child: const Text('Về trang chủ'),
                ),
              ] else ...[
                ElevatedButton.icon(
                  onPressed: () => context.pop(),
                  icon: const Icon(Symbols.refresh_rounded),
                  label: const Text('Thử lại'),
                ),
                const SizedBox(height: AppSpacing.sm),
                OutlinedButton(
                  onPressed: () => context.pop(),
                  child: const Text('Đổi phương thức thanh toán'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildReceiptRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(value, style: AppTextStyles.label),
        ],
      ),
    );
  }
}
