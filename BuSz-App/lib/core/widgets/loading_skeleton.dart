/// BusZ Shared Widget — Loading Skeleton
///
/// Source of Truth: BusZ-Documentation/06_Flutter/05_Home_Module.md §14
///                  BusZ-Documentation/02_UI/01_UI_Overview.md §13
///
/// Skeleton shimmer placeholders for loading states.
/// "Không hiển thị màn hình trắng" — always show skeleton instead.
library;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/theme/app_spacing.dart';

/// A single shimmer box placeholder.
class SkeletonBox extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;

  const SkeletonBox({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius = AppRadius.medium,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.gray200,
        borderRadius: BorderRadius.circular(borderRadius),
      ),
    );
  }
}

// Additional gray shade not in AppColors — used only for skeleton
extension _SkeletonColors on AppColors {
  // This is embedded directly in the SkeletonBox color above.
}

const Color _gray200 = Color(0xFFEEEEEE);

/// Shimmer wrapper that applies the loading animation.
class LoadingSkeleton extends StatelessWidget {
  final Widget child;

  const LoadingSkeleton({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.darkCard : _gray200,
      highlightColor: isDark ? AppColors.darkSurface : AppColors.gray50,
      child: child,
    );
  }
}

/// Pre-built: Card skeleton (for Trip, Ticket, etc.)
class SkeletonCard extends StatelessWidget {
  const SkeletonCard({super.key});

  @override
  Widget build(BuildContext context) {
    return LoadingSkeleton(
      child: Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: AppRadius.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: _gray200,
                    borderRadius: AppRadius.smallAll,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(width: 120, height: 14, color: _gray200),
                      const SizedBox(height: AppSpacing.xxs),
                      Container(width: 80, height: 10, color: _gray200),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(width: 60, height: 14, color: _gray200),
                Container(width: 40, height: 10, color: _gray200),
                Container(width: 60, height: 14, color: _gray200),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Pre-built: List of skeleton cards.
class SkeletonList extends StatelessWidget {
  final int itemCount;

  const SkeletonList({super.key, this.itemCount = 3});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(itemCount, (_) => const SkeletonCard()),
    );
  }
}
