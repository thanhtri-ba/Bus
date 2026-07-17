import 'package:flutter/material.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';

class AppSnackbar {
  static void show(
    BuildContext context, {
    required String message,
    bool isError = false,
    bool isSuccess = false,
  }) {
    Color backgroundColor = AppColors.backgroundPrimary;
    Color textColor = AppColors.textPrimary;

    if (isError) {
      backgroundColor = AppColors.error;
      textColor = AppColors.textWhite;
    } else if (isSuccess) {
      backgroundColor = AppColors.success;
      textColor = AppColors.textWhite;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: AppTextStyles.textMediumMedium.copyWith(color: textColor),
        ),
        backgroundColor: backgroundColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
