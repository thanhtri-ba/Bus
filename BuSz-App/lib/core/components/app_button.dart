import 'package:flutter/material.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/theme/app_spacing.dart';

enum AppButtonVariant { primary, secondary, outline, text }

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final bool isLoading;
  final bool isFullWidth;
  final IconData? icon;

  const AppButton({
    super.key,
    required this.text,
    this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.isLoading = false,
    this.isFullWidth = true,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isDisabled = onPressed == null || isLoading;

    Color getBackgroundColor() {
      if (isDisabled &&
          variant != AppButtonVariant.text &&
          variant != AppButtonVariant.outline) {
        return AppColors.backgroundDisabled;
      }
      switch (variant) {
        case AppButtonVariant.primary:
          return AppColors.primary;
        case AppButtonVariant.secondary:
          return AppColors.backgroundSecondary;
        case AppButtonVariant.outline:
        case AppButtonVariant.text:
          return Colors.transparent;
      }
    }

    Color getTextColor() {
      if (isDisabled) return AppColors.textDisabled;
      switch (variant) {
        case AppButtonVariant.primary:
          return AppColors.textWhite;
        case AppButtonVariant.secondary:
          return AppColors.textPrimary;
        case AppButtonVariant.outline:
        case AppButtonVariant.text:
          return AppColors.primary;
      }
    }

    BorderSide? getBorder() {
      if (variant == AppButtonVariant.outline) {
        return BorderSide(
          color: isDisabled ? AppColors.borderStrong : AppColors.primary,
        );
      }
      if (variant == AppButtonVariant.secondary) {
        return BorderSide(color: AppColors.borderNormal);
      }
      return null;
    }

    Widget content = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isLoading) ...[
          SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(getTextColor()),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
        ] else if (icon != null) ...[
          Icon(icon, size: 20, color: getTextColor()),
          const SizedBox(width: AppSpacing.xs),
        ],
        Text(text, style: AppTextStyles.label.copyWith(color: getTextColor())),
      ],
    );

    final buttonStyle = ElevatedButton.styleFrom(
      backgroundColor: getBackgroundColor(),
      elevation: 0,
      shadowColor: Colors.transparent,
      padding: const EdgeInsets.symmetric(
        vertical: 14,
        horizontal: AppSpacing.lg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: AppRadius.mediumAll,
        side: getBorder() ?? BorderSide.none,
      ),
    );

    Widget buttonWidget;
    if (variant == AppButtonVariant.text) {
      buttonWidget = TextButton(
        onPressed: isDisabled ? null : onPressed,
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(
            vertical: 14,
            horizontal: AppSpacing.lg,
          ),
          shape: RoundedRectangleBorder(borderRadius: AppRadius.mediumAll),
        ),
        child: content,
      );
    } else {
      buttonWidget = ElevatedButton(
        onPressed: isDisabled ? null : onPressed,
        style: buttonStyle,
        child: content,
      );
    }

    return isFullWidth
        ? SizedBox(width: double.infinity, child: buttonWidget)
        : buttonWidget;
  }
}
