import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:busz/providers/theme_provider.dart';
import 'dart:ui';

class HomeSearchCard extends StatefulWidget {
  const HomeSearchCard({super.key});

  @override
  State<HomeSearchCard> createState() => _HomeSearchCardState();
}

class _HomeSearchCardState extends State<HomeSearchCard>
    with SingleTickerProviderStateMixin {
  String _departure = 'TP.HCM';
  String _destination = 'Đà Lạt';
  final String _date = 'Hôm nay';
  int _passengerCount = 1;
  bool _isRoundTrip = false;

  late final AnimationController _animCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOut));
    _slideAnim = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _animCtrl, curve: Curves.easeOutCubic));
    _animCtrl.forward();
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickLocation(bool isDestination) async {
    final result = await context.push<String>(
      '${RouteNames.searchCity}${isDestination ? '?destination=true' : ''}',
    );
    if (result != null) {
      setState(() {
        if (isDestination) {
          _destination = result;
        } else {
          _departure = result;
        }
      });
    }
  }

  void _swapLocations() {
    setState(() {
      final temp = _departure;
      _departure = _destination;
      _destination = temp;
    });
  }

  void _search() {
    context.read<BookingProvider>().setSearch(
      departure: _departure,
      destination: _destination,
      date: _date,
      passengerCount: _passengerCount,
    );
    context.push(RouteNames.searchResults);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return FadeTransition(
      opacity: _fadeAnim,
      child: SlideTransition(
        position: _slideAnim,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 24),
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.darkCard : Colors.white,
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: const Color(
                  0xFF00BCD4,
                ).withValues(alpha: isDark ? 0.1 : 0.05),
                blurRadius: 32,
                offset: const Offset(0, 16),
              ),
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
            border: Border.all(
              color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
            ),
          ),
          child: Column(
            children: [
              // Trip Type Toggle
              Container(
                height: 44,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white.withValues(alpha: 0.05) : const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isRoundTrip = false),
                        child: Container(
                          decoration: BoxDecoration(
                            color: !_isRoundTrip ? (isDark ? const Color(0xFF334155) : Colors.white) : Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: !_isRoundTrip ? [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                            ] : null,
                          ),
                          child: Center(
                            child: Text(
                              'Một chiều',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: !_isRoundTrip 
                                    ? (isDark ? Colors.white : const Color(0xFF0F172A))
                                    : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: GestureDetector(
                        onTap: () => setState(() => _isRoundTrip = true),
                        child: Container(
                          decoration: BoxDecoration(
                            color: _isRoundTrip ? (isDark ? const Color(0xFF334155) : Colors.white) : Colors.transparent,
                            borderRadius: BorderRadius.circular(18),
                            boxShadow: _isRoundTrip ? [
                              BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 4, offset: const Offset(0, 2))
                            ] : null,
                          ),
                          child: Center(
                            child: Text(
                              'Khứ hồi',
                              style: TextStyle(
                                fontFamily: 'Inter',
                                fontWeight: FontWeight.w600,
                                fontSize: 13,
                                color: _isRoundTrip 
                                    ? (isDark ? Colors.white : const Color(0xFF0F172A))
                                    : (isDark ? AppColors.darkTextSecondary : const Color(0xFF64748B)),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Locations Area
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Column(
                    children: [
                      _buildOutlinedField(
                        icon: Symbols.my_location_rounded,
                        iconColor: const Color(0xFF00BCD4), // Primary
                        label: 'Departure',
                        value: _departure,
                        isDark: isDark,
                        onTap: () => _pickLocation(false),
                      ),
                      const SizedBox(height: 12),
                      _buildOutlinedField(
                        icon: Symbols.location_on_rounded,
                        iconColor: const Color(
                          0xFFEF4444,
                        ), // Red for destination
                        label: 'Destination',
                        value: _destination,
                        isDark: isDark,
                        onTap: () => _pickLocation(true),
                      ),
                    ],
                  ),
                  Positioned(
                    right: 24,
                    child: GestureDetector(
                      onTap: _swapLocations,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 8, sigmaY: 8),
                          child: Container(
                            width: 44,
                            height: 44,
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [Color(0xFF18C5D8), Color(0xFF0099C5)],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF0099C5,
                                  ).withValues(alpha: 0.3),
                                  blurRadius: 12,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Symbols.swap_vert_rounded,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Date & Passengers
              Row(
                children: [
                  Expanded(
                    flex: _isRoundTrip ? 4 : 3,
                    child: _buildOutlinedField(
                      icon: Symbols.calendar_month_rounded,
                      iconColor: const Color(0xFF0097A7),
                      label: _isRoundTrip ? 'Ngày đi - Ngày về' : 'Ngày đi',
                      value: _isRoundTrip ? 'Hôm nay - Thêm ngày' : _date,
                      isDark: isDark,
                      onTap: () {}, // Pick date
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    flex: 3,
                    child: _buildOutlinedField(
                      icon: Symbols.group_rounded,
                      iconColor: const Color(0xFF0097A7),
                      label: 'Hành khách',
                      value: '$_passengerCount',
                      isDark: isDark,
                      onTap: _showPassengerBottomSheet,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Search Button
              SizedBox(
                width: double.infinity,
                height: 58,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                    gradient: const LinearGradient(
                      colors: [Color(0xFF18C5D8), Color(0xFF0099C5)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF0099C5).withValues(alpha: 0.3),
                        blurRadius: 16,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: _search,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Symbols.search_rounded, size: 20),
                        const SizedBox(width: 8),
                        const Text(
                          'Search Buses',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOutlinedField({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
    required bool isDark,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 60,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : const Color(0xFFF8FAFC),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 24),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    label,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      color: isDark
                          ? AppColors.darkTextSecondary
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPassengerBottomSheet() {
    int tempCount = _passengerCount;
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setModalState) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Passengers',
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: tempCount > 1
                              ? () => setModalState(() => tempCount--)
                              : null,
                          icon: const Icon(
                            Symbols.remove_circle_outline_rounded,
                            size: 36,
                          ),
                          color: const Color(0xFF00BCD4),
                        ),
                        const SizedBox(width: 32),
                        Text(
                          '$tempCount',
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 32),
                        IconButton(
                          onPressed: tempCount < 10
                              ? () => setModalState(() => tempCount++)
                              : null,
                          icon: const Icon(
                            Symbols.add_circle_outline_rounded,
                            size: 36,
                          ),
                          color: const Color(0xFF00BCD4),
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            _passengerCount = tempCount;
                          });
                          Navigator.pop(context);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF00BCD4),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text(
                          'Confirm',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
