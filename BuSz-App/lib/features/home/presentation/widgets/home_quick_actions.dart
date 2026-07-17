import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/theme_provider.dart';
import 'package:provider/provider.dart';

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    final actions = [
      (
        icon: Symbols.confirmation_number_rounded,
        label: 'My Tickets',
        color: const Color(0xFF8B5CF6),
        onTap: () => context.go(RouteNames.bookings),
      ),
      (
        icon: Symbols.local_offer_rounded,
        label: 'Promotions',
        color: const Color(0xFFF59E0B),
        onTap: () => context.push(RouteNames.promos),
      ),
      (
        icon: Symbols.smart_toy_rounded,
        label: 'AI Assistant',
        color: const Color(0xFFEC4899),
        onTap: () => context.go(RouteNames.aiChat),
      ),
      (
        icon: Symbols.history_rounded,
        label: 'Recent Trips',
        color: const Color(0xFF10B981),
        onTap: () {}, // Handled by business logic
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: actions
            .map(
              (a) => _PremiumActionCard(
                icon: a.icon,
                label: a.label,
                color: a.color,
                isDark: isDark,
                onTap: a.onTap,
              ),
            )
            .toList(),
      ),
    );
  }
}

class _PremiumActionCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _PremiumActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  State<_PremiumActionCard> createState() => _PremiumActionCardState();
}

class _PremiumActionCardState extends State<_PremiumActionCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnim = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _ctrl.forward(),
      onTapUp: (_) {
        _ctrl.reverse();
        widget.onTap();
      },
      onTapCancel: () => _ctrl.reverse(),
      behavior: HitTestBehavior.opaque,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: SizedBox(
          width: 76, // Slightly wider to fit text nicely
          child: Column(
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: widget.isDark
                      ? widget.color.withValues(alpha: 0.15)
                      : widget.color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: widget.isDark
                        ? widget.color.withValues(alpha: 0.2)
                        : Colors.transparent,
                  ),
                ),
                child: Center(
                  child: Icon(
                    widget.icon,
                    color: widget.isDark
                        ? widget.color.withValues(alpha: 0.9)
                        : widget.color,
                    size: 28,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                widget.label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: widget.isDark
                      ? AppColors.darkTextSecondary
                      : const Color(0xFF64748B),
                  height: 1.2,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
