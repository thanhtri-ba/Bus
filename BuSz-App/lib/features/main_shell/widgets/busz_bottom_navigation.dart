import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';

class BuszBottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const BuszBottomNavigation({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BuszBottomNavigation> createState() => _BuszBottomNavigationState();
}

class _BuszBottomNavigationState extends State<BuszBottomNavigation>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;

  final List<({IconData icon, String label})> _items = [
    (icon: Symbols.home_rounded, label: 'Trang chủ'),
    (icon: Symbols.confirmation_number_rounded, label: 'Vé của tôi'),
    (icon: Symbols.smart_toy_rounded, label: 'AI Chat'),
    (icon: Symbols.local_offer_rounded, label: 'Khuyến mãi'),
    (icon: Symbols.person_rounded, label: 'Tài khoản'),
  ];

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _items.length,
      (_) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
      ),
    );
    _controllers[widget.selectedIndex].value = 1.0;
  }

  @override
  void didUpdateWidget(BuszBottomNavigation old) {
    super.didUpdateWidget(old);
    if (old.selectedIndex != widget.selectedIndex) {
      _controllers[old.selectedIndex].reverse();
      _controllers[widget.selectedIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
        child: Container(
          height: 72,
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF00BCD4,
                ).withValues(alpha: isDark ? 0.08 : 0.15),
                blurRadius: 24,
                offset: const Offset(0, 8),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isDark
                  ? Colors.white12
                  : const Color(0xFFE5E7EB).withValues(alpha: 0.5),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_items.length, _buildTab),
          ),
        ),
      ),
    );
  }

  Widget _buildTab(int index) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final item = _items[index];
    final inactiveColor = isDark
        ? AppColors.darkTextSecondary
        : const Color(0xFF94A3B8);

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => widget.onItemTapped(index),
        child: AnimatedBuilder(
          animation: _controllers[index],
          builder: (context, _) {
            final t = _controllers[index].value;
            return Stack(
              alignment: Alignment.center,
              children: [
                // Pill Background when active
                if (t > 0)
                  Opacity(
                    opacity: t,
                    child: Container(
                      width: 52,
                      height: 52,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF18C5D8), Color(0xFF0099C5)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(
                              0xFF0099C5,
                            ).withValues(alpha: 0.3 * t),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                    ),
                  ),

                // Icon
                Transform.translate(
                  offset: Offset(0, -6 * t),
                  child: Icon(
                    item.icon,
                    size: 24,
                    color: Color.lerp(inactiveColor, Colors.white, t),
                    fill: t, // fill icon when active
                  ),
                ),

                // Label (fades in below icon when active)
                if (t > 0)
                  Positioned(
                    bottom: 12,
                    child: Opacity(
                      opacity: t,
                      child: Text(
                        item.label,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          letterSpacing: 0.2,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.visible,
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}
