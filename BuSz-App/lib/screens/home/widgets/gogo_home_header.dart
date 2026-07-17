import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';

class TravelEasyHeader extends StatelessWidget {
  const TravelEasyHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Symbols.directions_bus_rounded,
                  color: AppColors.primary,
                  size: 24,
                ),
                const SizedBox(width: 8),
                Text(
                  'TravelEasy',
                  style: TextStyle(
                    fontFamily:
                        'Inter', // Assuming Inter based on typical modern fonts
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Symbols.notifications_active_rounded,
                color: AppColors.primary,
                size: 20,
              ),
            ),
          ],
        ),
        const SizedBox(height: 32),
        const Text(
          'Khám phá hành trình mới\ncùng TravelEasy',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w800,
            fontSize: 24,
            height: 1.3,
            color: AppColors.secondary, // Dark blue text
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'Đặt vé xe nhanh chóng, an tâm trên mọi nẻo đường',
          style: TextStyle(
            fontFamily: 'Inter',
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
