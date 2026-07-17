import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:busz/models/home_models.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/components/app_button.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

class VoucherDetailScreen extends StatelessWidget {
  final Promo promo;

  const VoucherDetailScreen({super.key, required this.promo});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: AppColors.primary,
            iconTheme: const IconThemeData(color: Colors.white),
            flexibleSpace: FlexibleSpaceBar(
              background: promo.logoPath.isNotEmpty
                  ? CachedNetworkImage(
                      imageUrl: promo.logoPath,
                      fit: BoxFit.cover,
                      errorWidget: (_, _, _) =>
                          Container(color: AppColors.primary),
                    )
                  : Container(color: AppColors.primary),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    promo.title,
                    style: AppTextStyles.headline.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    promo.subtitle,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  _buildCodeBox(context),
                  const SizedBox(height: AppSpacing.xl),
                  Text(
                    'Ã„ÂiÃ¡Â»Âu kiÃ¡Â»â€¡n ÃƒÂ¡p dÃ¡Â»Â¥ng',
                    style: AppTextStyles.titleLarge.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _buildConditionItem(
                    Symbols.check_circle_rounded,
                    'GiÃ¡ÂºÂ£m tÃ¡Â»â€˜i Ã„â€˜a ${promo.discountAmount}Ã„â€˜',
                  ),
                  _buildConditionItem(
                    Symbols.check_circle_rounded,
                    'ÃƒÂp dÃ¡Â»Â¥ng cho mÃ¡Â»Âi tuyÃ¡ÂºÂ¿n Ã„â€˜Ã†Â°Ã¡Â»Âng',
                  ),
                  _buildConditionItem(
                    Symbols.check_circle_rounded,
                    'KhÃƒÂ´ng ÃƒÂ¡p dÃ¡Â»Â¥ng cÃƒÂ¹ng khuyÃ¡ÂºÂ¿n mÃƒÂ£i khÃƒÂ¡c',
                  ),
                  const SizedBox(height: 100), // padding for bottom button
                ],
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              offset: const Offset(0, -4),
              blurRadius: 10,
            ),
          ],
        ),
        child: AppButton(
          text: 'SÃ¡Â»Â­ dÃ¡Â»Â¥ng ngay',
          onPressed: () {
            // Apply promo and return to home or booking
            context.read<BookingProvider>().applyPromo(promo.id);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Ã„ÂÃƒÂ£ ÃƒÂ¡p dÃ¡Â»Â¥ng mÃƒÂ£ ${promo.id}!'),
              ),
            );
            if (context.canPop()) {
              context.pop();
            } else {
              context.go(RouteNames.home);
            }
          },
        ),
      ),
    );
  }

  Widget _buildCodeBox(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.primaryLight.withValues(alpha: 0.3),
        borderRadius: AppRadius.largeAll,
        border: Border.all(color: AppColors.primary.withValues(alpha: 0.2)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'MÃƒÂ£ giÃ¡ÂºÂ£m giÃƒÂ¡',
                style: AppTextStyles.label.copyWith(color: AppColors.primary),
              ),
              const SizedBox(height: 4),
              Text(
                promo.id,
                style: AppTextStyles.titleLarge.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(
              Symbols.content_copy_rounded,
              color: AppColors.primary,
            ),
            onPressed: () {
              Clipboard.setData(ClipboardData(text: promo.id));
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Ã„ÂÃƒÂ£ copy mÃƒÂ£ giÃ¡ÂºÂ£m giÃƒÂ¡'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildConditionItem(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: AppColors.primary),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
