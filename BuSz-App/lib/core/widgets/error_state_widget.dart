/// BusZ Shared Widget — Error State
///
/// Source of Truth: BusZ-Documentation/06_Flutter/05_Home_Module.md §16
///                  BusZ-Documentation/02_UI/01_UI_Overview.md §15
///
/// Shows error message with Retry and optional Back actions.
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

class ErrorStateWidget extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  const ErrorStateWidget({
    super.key,
    this.message = 'Something went wrong.',
    this.onRetry,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                color: AppColors.errorLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Symbols.error_outline_rounded,
                size: 40,
                color: AppColors.error,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            if (onRetry != null)
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Symbols.refresh_rounded, size: 20),
                label: const Text('Retry'),
              ),
            if (onBack != null) ...[
              const SizedBox(height: AppSpacing.sm),
              TextButton(onPressed: onBack, child: const Text('Back')),
            ],
          ],
        ),
      ),
    );
  }
}
