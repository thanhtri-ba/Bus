import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:busz/providers/theme_provider.dart';
import 'package:busz/core/theme/app_colors.dart';

class HomeStatistics extends StatelessWidget {
  const HomeStatistics({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    final stats = [
      (
        icon: Symbols.route_rounded,
        value: '500+',
        label: 'Routes',
        color: const Color(0xFF00BCD4),
      ),
      (
        icon: Symbols.groups_rounded,
        value: '2M+',
        label: 'Passengers',
        color: const Color(0xFF8B5CF6),
      ),
      (
        icon: Symbols.schedule_rounded,
        value: '99%',
        label: 'On Time',
        color: const Color(0xFF10B981),
      ),
      (
        icon: Symbols.star_rounded,
        value: '4.9★',
        label: 'Rating',
        color: const Color(0xFFF59E0B),
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: stats
            .map(
              (s) => _buildStatCard(
                icon: s.icon,
                value: s.value,
                label: s.label,
                color: s.color,
                isDark: isDark,
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required bool isDark,
  }) {
    return Container(
      width: 76,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkCard : Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
        ),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: isDark ? Colors.white : const Color(0xFF0F172A),
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              fontFamily: 'Inter',
              fontSize: 10,
              fontWeight: FontWeight.w500,
              color: isDark
                  ? AppColors.darkTextSecondary
                  : const Color(0xFF64748B),
            ),
          ),
        ],
      ),
    );
  }
}
