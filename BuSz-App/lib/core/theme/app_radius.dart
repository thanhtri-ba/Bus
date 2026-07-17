import 'package:flutter/material.dart';

/// BusZ UI Kit — radius tokens.
class AppRadius {
  AppRadius._();

  static const double xs = 6;
  static const double small = 8;
  static const double medium = 12;
  static const double large = 16;
  static const double extraLarge = 24;
  static const double xxl = 32;
  static const double pill = 999;

  static BorderRadius radius(double value) => BorderRadius.circular(value);

  static final BorderRadius xsAll = BorderRadius.circular(xs);
  static final BorderRadius smallAll = BorderRadius.circular(small);
  static final BorderRadius mediumAll = BorderRadius.circular(medium);
  static final BorderRadius largeAll = BorderRadius.circular(large);
  static final BorderRadius extraLargeAll = BorderRadius.circular(extraLarge);
  static final BorderRadius xxlAll = BorderRadius.circular(xxl);
  static final BorderRadius pillAll = BorderRadius.circular(pill);

  static final BorderRadius card = BorderRadius.circular(20);
  static final BorderRadius cardLarge = BorderRadius.circular(28);
  static final BorderRadius button = BorderRadius.circular(16);
  static final BorderRadius input = BorderRadius.circular(16);
  static final BorderRadius dialog = BorderRadius.circular(28);

  static const BorderRadius bottomSheet = BorderRadius.only(
    topLeft: Radius.circular(28),
    topRight: Radius.circular(28),
  );

  // Missing tokens aliased
  static const double smBorder = small;
  static const double mdBorder = medium;
  static const double lg = large;
}
