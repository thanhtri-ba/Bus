import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/core/components/app_header.dart';

class SelectVerificationScreen extends StatelessWidget {
  final String phone;

  const SelectVerificationScreen({super.key, required this.phone});

  void _navigateToOtp(BuildContext context) {
    context.push(RouteNames.otp, extra: {'phone': phone});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const AppHeader(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),

              Text(
                'Verification Method',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayXSSemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),

              const SizedBox(height: AppSpacing.md),

              Text(
                'Select verification method below to continue.',
                textAlign: TextAlign.center,
                style: AppTextStyles.textMediumRegular.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // SMS Option
              _buildMethodCard(
                icon: Icons.phone_android,
                iconColor: const Color(0xFF1877F2), // Brand Blue
                title: 'Send message to',
                phone: phone,
                onTap: () => _navigateToOtp(context),
              ),

              const SizedBox(height: AppSpacing.md),

              // WhatsApp Option
              _buildMethodCard(
                icon: Icons.chat_bubble_outline, // WhatsApp placeholder
                iconColor: const Color(0xFF25D366), // WhatsApp Green
                title: 'WhatsApp to',
                phone: phone,
                onTap: () => _navigateToOtp(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMethodCard({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String phone,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.borderSecondary),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 28),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.textMediumMedium.copyWith(
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    phone,
                    style: AppTextStyles.textSmallRegular.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
