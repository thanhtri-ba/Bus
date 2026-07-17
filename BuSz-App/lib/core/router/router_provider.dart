import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/features/auth/domain/providers/auth_state_provider.dart';

// Screens
import 'package:busz/screens/onboarding/splash_screen.dart';
import 'package:busz/screens/onboarding/onboarding_screen.dart';
import 'package:busz/screens/auth/auth_screen.dart';
import 'package:busz/features/auth/presentation/screens/select_verification_screen.dart';
import 'package:busz/features/auth/presentation/screens/otp_screen.dart';
import 'package:busz/screens/home/home_screen.dart';
import 'package:busz/screens/home/search_results_screen.dart';
import 'package:busz/features/main_shell/main_shell_screen.dart';

// (Other imports can be added as needed)
import 'package:busz/features/ticket/presentation/screens/ticket_list_screen.dart';
import 'package:busz/features/notification/presentation/screens/notification_screen.dart';
import 'package:busz/features/profile/presentation/screens/profile_screen.dart';
import 'package:busz/features/booking/presentation/screens/seat_selection_screen.dart';
import 'package:busz/features/booking/presentation/screens/passenger_info_screen.dart';
import 'package:busz/features/payment/presentation/screens/payment_screen.dart';
import 'package:busz/features/payment/presentation/screens/payment_result_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final routerProvider = Provider<GoRouter>((ref) {
  final authState = ref.watch(authStateProvider);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final isInitial = authState == AuthState.initial;
      final isAuth = authState == AuthState.authenticated;
      final isSplash = state.matchedLocation == RouteNames.splash;
      final isOnboarding = state.matchedLocation == RouteNames.onboarding;
      final isAuthRoute =
          state.matchedLocation == RouteNames.auth ||
          state.matchedLocation == RouteNames.otp;

      if (isInitial) {
        return isSplash ? null : RouteNames.splash;
      }

      if (isSplash) {
        return isAuth ? RouteNames.home : RouteNames.onboarding;
      }

      if (!isAuth) {
        if (isAuthRoute || isOnboarding) return null;
        return RouteNames
            .auth; // redirect to login if accessing protected route
      } else {
        if (isAuthRoute || isOnboarding) {
          return RouteNames
              .home; // redirect to home if logged in and accessing auth
        }
      }

      return null;
    },
    routes: [
      GoRoute(
        path: RouteNames.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: RouteNames.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: RouteNames.auth,
        builder: (context, state) => const AuthScreen(),
      ),
      GoRoute(
        path: RouteNames.selectVerification,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return SelectVerificationScreen(phone: extra?['phone'] ?? '');
        },
      ),
      GoRoute(
        path: RouteNames.otp,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpScreen(phone: extra?['phone'] ?? '');
        },
      ),

      // Main App Shell with Bottom Navigation
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShellScreen(child: child),
        routes: [
          GoRoute(
            path: RouteNames.home,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: HomeScreen()),
          ),
          GoRoute(
            path: RouteNames.bookings,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: TicketListScreen()),
          ),
          GoRoute(
            path: RouteNames.notifications,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: NotificationScreen()),
          ),
          GoRoute(
            path: RouteNames.profile,
            pageBuilder: (context, state) =>
                const NoTransitionPage(child: ProfileScreen()),
          ),
        ],
      ),

      // Nested flows (Booking)
      GoRoute(
        path: RouteNames.searchResults,
        builder: (context, state) => const SearchResultsScreen(),
      ),
      GoRoute(
        path: '/trip/:tripId/seats',
        builder: (context, state) {
          final tripId = state.pathParameters['tripId'] ?? '';
          return SeatSelectionScreen(tripId: tripId);
        },
      ),
      GoRoute(
        path: RouteNames.passengerInfo,
        builder: (context, state) => const PassengerInfoScreen(),
      ),
      GoRoute(
        path: RouteNames.payment,
        builder: (context, state) => const PaymentScreen(),
      ),
      GoRoute(
        path: RouteNames.paymentResult,
        builder: (context, state) {
          final success = state.uri.queryParameters['success'] == 'true';
          return PaymentResultScreen(isSuccess: success);
        },
      ),
    ],
  );
});
