import 'package:flutter/material.dart';

/// BusZ UI Kit — elevation/shadow tokens.
class AppShadows {
  AppShadows._();

  static const List<BoxShadow> none = [];

  static List<BoxShadow> soft = [
    BoxShadow(
      color: const Color(0xFF101828).withValues(alpha: 0.06),
      blurRadius: 18,
      offset: const Offset(0, 8),
    ),
  ];

  static List<BoxShadow> card = [
    BoxShadow(
      color: const Color(0xFF101828).withValues(alpha: 0.08),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static List<BoxShadow> floating = [
    BoxShadow(
      color: const Color(0xFF101828).withValues(alpha: 0.12),
      blurRadius: 32,
      offset: const Offset(0, 16),
    ),
  ];

  // Missing tokens aliased
  static List<BoxShadow> shadowXS = soft;
}
