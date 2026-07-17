/// BusZ Navigation — Route Name Constants
///
/// Source of Truth: BusZ-Documentation/06_Flutter/03_Navigation.md §4-5
///
/// Centralized route path constants. Never hardcode route strings in widgets.
class RouteNames {
  RouteNames._();

  // ─── Public Routes ──────────────────────────────────────────────
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String auth = '/auth';
  static const String register = '/register';
  static const String otp = '/otp';
  static const String selectVerification = '/select-verification';
  static const String countryCode = '/country-code';
  static const String loginPassword = '/login-password';
  static const String setPassword = '/set-password';
  static const String forgotPassword = '/forgot-password';
  static const String setNewPassword = '/set-new-password';

  // ─── Main Shell (Protected, Bottom Nav) ─────────────────────────
  static const String home = '/home';
  static const String promos = '/promos';
  static const String voucherDetail = '/promos/detail';
  static const String destinations = '/destinations';
  static const String search = '/search';
  static const String bookings = '/bookings';
  static const String notifications = '/notifications';
  static const String profile = '/profile';
  static const String aiChat = '/ai-chat';

  // ─── Search Flow ────────────────────────────────────────────────
  static const String intercitySearch = '/intercity-search';
  static const String searchCity = '/search-city';
  static const String searchResults = '/search-results';

  // ─── Booking Flow (Protected) ───────────────────────────────────
  static const String tripDetail = '/trip/:tripId';
  static const String seatSelection = '/trip/:tripId/seats';
  static const String passengerInfo = '/booking/passengers';
  static const String bookingSummary = '/booking/summary';

  // ─── Payment (Protected) ────────────────────────────────────────
  static const String payment = '/payment';
  static const String paymentResult = '/payment/result';

  // ─── Ticket (Protected) ─────────────────────────────────────────
  static const String ticketList = bookings;
  static const String ticketDetail = '$bookings/:ticketId';

  // ─── Profile Sub-routes (Protected) ─────────────────────────────
  static const String editProfile = '/profile/edit';
  static const String changePassword = '/profile/change-password';
  static const String favoriteRoutes = '/profile/favorites';
  static const String bookingHistory = '/profile/history';
  static const String myAddress = '/profile/address';
  static const String paymentMethods = '/profile/payment-methods';
  static const String settings = '/settings';
  static const String privacyPolicy = '/settings/privacy';
  static const String termsOfUse = '/settings/terms';
}
