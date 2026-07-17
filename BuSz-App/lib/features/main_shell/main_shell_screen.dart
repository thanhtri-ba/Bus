/// BusZ Main Shell — Bottom Navigation Shell
///
/// Source of Truth: BusZ-Documentation/06_Flutter/03_Navigation.md §6-7
///
/// ShellRoute wrapper that provides the 5-tab bottom navigation:
/// Home → Bookings → Notifications → Profile
///
/// Each tab maintains its own navigation stack (Nested Navigation).
library;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/features/main_shell/widgets/busz_bottom_navigation.dart';

class MainShellScreen extends StatelessWidget {
  final Widget child;

  const MainShellScreen({super.key, required this.child});

  int _calculateSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    if (location.startsWith(RouteNames.home)) return 0;
    if (location.startsWith(RouteNames.bookings)) return 1;
    if (location.startsWith(RouteNames.aiChat)) return 2;
    if (location.startsWith(RouteNames.notifications)) return 3;
    if (location.startsWith(RouteNames.profile)) return 4;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.bookings);
        break;
      case 2:
        context.go(RouteNames.aiChat);
        break;
      case 3:
        context.go(RouteNames.notifications);
        break;
      case 4:
        context.go(RouteNames.profile);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final selectedIndex = _calculateSelectedIndex(context);

    return Scaffold(
      extendBody: true,
      body: child,
      bottomNavigationBar: BuszBottomNavigation(
        selectedIndex: selectedIndex,
        onItemTapped: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
