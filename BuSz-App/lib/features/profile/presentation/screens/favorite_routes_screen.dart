import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';

class FavoriteRoutesScreen extends StatelessWidget {
  const FavoriteRoutesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: AppBar(
        title: Text('Tuyến đường yêu thích', style: AppTextStyles.titleLarge),
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
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: [
          _buildFavoriteCard('Hà Nội', 'Sapa', 'G5 Bus', 450000),
          _buildFavoriteCard('Hồ Chí Minh', 'Đà Lạt', 'Phương Trang', 350000),
        ],
      ),
    );
  }

  Widget _buildFavoriteCard(String from, String to, String bus, double price) {
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
            children: [
              const Icon(
                Symbols.directions_bus_rounded,
                color: AppColors.primary,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text('$from - $to', style: AppTextStyles.titleMedium),
              ),
              const Icon(Symbols.favorite_rounded, color: AppColors.error),
            ],
          ),
          const SizedBox(height: 12),
          Text(bus, style: AppTextStyles.bodyMedium),
          const SizedBox(height: 4),
          Text(
            '${price.toInt()} ₫',
            style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary),
          ),
        ],
      ),
    );
  }
}
