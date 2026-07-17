import 'package:flutter/material.dart';

/// BusZ UI Kit — modern color tokens.
///
/// Keep old token names so existing screens still compile while giving the
/// whole app a more premium, consistent visual base.
class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF0796A8);
  static const Color primaryDark = Color(0xFF006D7D);
  static const Color primaryLight = Color(0xFFE6F8FA);
  static const Color primarySoft = Color(0xFFF1FCFD);

  static const Color secondary = Color(0xFF0F2A43);
  static const Color secondaryLight = Color(0xFFEAF2F8);
  static const Color accent = Color(0xFFFFB547);
  static const Color accentLight = Color(0xFFFFF6E4);

  // Semantic
  static const Color success = Color(0xFF16A34A);
  static const Color successLight = Color(0xFFEAF8EF);
  static const Color warning = Color(0xFFF59E0B);
  static const Color warningLight = Color(0xFFFFF7E8);
  static const Color error = Color(0xFFE5484D);
  static const Color errorLight = Color(0xFFFFECEE);
  static const Color info = Color(0xFF2563EB);
  static const Color infoLight = Color(0xFFEAF1FF);

  // Neutral
  static const Color black = Color(0xFF101828);
  static const Color gray900 = Color(0xFF1D2939);
  static const Color gray800 = Color(0xFF344054);
  static const Color gray700 = Color(0xFF475467);
  static const Color gray600 = Color(0xFF667085);
  static const Color gray500 = Color(0xFF98A2B3);
  static const Color gray400 = Color(0xFFD0D5DD);
  static const Color gray300 = Color(0xFFEAECF0);
  static const Color gray200 = Color(0xFFF2F4F7);
  static const Color gray100 = Color(0xFFF7F9FB);
  static const Color gray50 = Color(0xFFFCFCFD);
  static const Color white = Color(0xFFFFFFFF);

  // Background / Surface
  static const Color backgroundPrimary = Color(0xFFF6FAFC);
  static const Color backgroundSecondary = Color(0xFFFFFFFF);
  static const Color backgroundDisabled = Color(0xFFF2F4F7);
  static const Color surfacePrimary = Color(0xFFFFFFFF);
  static const Color surfaceCard = Color(0xFFFFFFFF);
  static const Color surfaceDialog = Color(0xFFFFFFFF);
  static const Color surfaceElevated = Color(0xFFFFFFFF);
  static const Color surfaceTint = Color(0xFFE6F8FA);

  // Border
  static const Color borderLight = Color(0xFFF2F4F7);
  static const Color borderNormal = Color(0xFFEAECF0);
  static const Color borderStrong = Color(0xFFD0D5DD);
  static const Color borderFocus = primary;
  static const Color borderError = error;

  // Text
  static const Color textPrimary = Color(0xFF101828);
  static const Color textSecondary = Color(0xFF667085);
  static const Color textTertiary = Color(0xFF98A2B3);
  static const Color textHint = Color(0xFF98A2B3);
  static const Color textDisabled = Color(0xFFD0D5DD);
  static const Color textWhite = Color(0xFFFFFFFF);
  static const Color textError = error;
  static const Color textSuccess = success;

  // Booking / Seat
  static const Color seatAvailable = Color(0xFF22C55E);
  static const Color seatSelected = primary;
  static const Color seatBooked = Color(0xFFD0D5DD);
  static const Color seatVIP = Color(0xFFFFC857);
  static const Color seatFemale = Color(0xFFEC4899);
  static const Color seatBlocked = Color(0xFF667085);

  // Payment
  static const Color paymentPending = warning;
  static const Color paymentSuccess = success;
  static const Color paymentFailed = error;
  static const Color paymentRefunded = Color(0xFF8B5CF6);

  // Route
  static const Color routeDeparture = Color(0xFF2563EB);
  static const Color routeArrival = Color(0xFF16A34A);
  static const Color routeCheckpoint = Color(0xFFF59E0B);

  static const List<Color> chartColors = [
    primary,
    success,
    warning,
    Color(0xFF8B5CF6),
    error,
    Color(0xFF14B8A6),
    Color(0xFF6366F1),
    Color(0xFF0EA5E9),
  ];

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF0DB4C4), Color(0xFF067989)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFFECFEFF), Color(0xFFFFFFFF), Color(0xFFFFF7E8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF2563EB)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient darkGradient = LinearGradient(
    colors: [Color(0xFF101828), Color(0xFF0F2A43)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Dark
  static const Color darkBackground = Color(0xFF08111A);
  static const Color darkSurface = Color(0xFF101828);
  static const Color darkCard = Color(0xFF162234);
  static const Color darkPrimary = Color(0xFF22D3EE);
  static const Color darkTextPrimary = Color(0xFFF8FAFC);
  static const Color darkTextSecondary = Color(0xFFCBD5E1);
  static const Color darkBorder = Color(0xFF263548);

  // Missing tokens aliased
  static const Color backgroundTertiary = gray100;
  static const Color backgroundBrand = primary;
  static const Color borderPrimary = borderStrong;
  static const Color borderSecondary = borderNormal;
  static const Color borderBrand = primary;
  static const Color fgPrimary = textPrimary;
  static const Color fgSecondary = textSecondary;
  static const Color textPlaceholder = textHint;
}
