import 'package:flutter/material.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

enum AppBadgeVariant { success, warning, error, info, defaultVariant }

class AppBadge extends StatelessWidget {
  final String text;
  final AppBadgeVariant variant;
  final IconData? icon;

  const AppBadge({
    super.key,
    required this.text,
    this.variant = AppBadgeVariant.defaultVariant,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    Color getBackgroundColor() {
      switch (variant) {
        case AppBadgeVariant.success:
          return const Color(0xFFECFDF3);
        case AppBadgeVariant.warning:
          return const Color(0xFFFFFAEB);
        case AppBadgeVariant.error:
          return const Color(0xFFFEF3F2);
        case AppBadgeVariant.info:
          return const Color(0xFFEFF8FF);
        case AppBadgeVariant.defaultVariant:
          return AppColors.backgroundTertiary;
      }
    }

    Color getTextColor() {
      switch (variant) {
        case AppBadgeVariant.success:
          return const Color(0xFF067647);
        case AppBadgeVariant.warning:
          return const Color(0xFFB54708);
        case AppBadgeVariant.error:
          return const Color(0xFFB42318);
        case AppBadgeVariant.info:
          return const Color(0xFF175CD3);
        case AppBadgeVariant.defaultVariant:
          return AppColors.textSecondary;
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xxs,
      ),
      decoration: BoxDecoration(
        color: getBackgroundColor(),
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: getTextColor()),
            const SizedBox(width: AppSpacing.xxs),
          ],
          Text(
            text,
            style: AppTextStyles.textXSMedium.copyWith(color: getTextColor()),
          ),
        ],
      ),
    );
  }
}
