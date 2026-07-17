import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/providers/theme_provider.dart';
import 'package:busz/services/user_service.dart';
import 'package:busz/models/home_models.dart';
import 'package:busz/services/promo_service.dart';
import 'package:busz/services/bus_service.dart';
import 'package:busz/core/widgets/shimmer_loading.dart';

import '../widgets/home_header.dart';
import '../widgets/home_search_card.dart';
import '../widgets/home_quick_actions.dart';
import '../widgets/home_promotion_carousel.dart';
import '../widgets/home_popular_routes.dart';
import '../widgets/home_featured_destinations.dart';
import '../widgets/home_statistics.dart';
import '../widgets/home_reviews.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  UserProfile? _profile;
  List<Promo> _promos = [];
  List<City> _destinations = [];
  List<Map<String, dynamic>> _popularRoutes = [];
  bool _isLoading = true;
  late final AnimationController _fadeCtrl;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _loadData();
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    super.dispose();
  }

  Future<void> _loadData() async {
    try {
      final results = await Future.wait([
        UserService.getProfile(),
        PromoService.getPromotions(),
        BusService.getPopularCities(),
        BusService.getPopularRoutes(),
      ]);
      if (mounted) {
        setState(() {
          _profile = results[0] as UserProfile?;
          _promos = results[1] as List<Promo>;
          _destinations = results[2] as List<City>;
          _popularRoutes = results[3] as List<Map<String, dynamic>>;
          _isLoading = false;
        });
        _fadeCtrl.forward();
      }
    } catch (_) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  String get _firstName {
    final name = _profile?.name ?? '';
    if (name.isEmpty) return 'Guest';
    return name.split(' ').last;
  }

  String get _greeting {
    final h = DateTime.now().hour;
    if (h >= 5 && h < 12) return 'Good Morning';
    if (h >= 12 && h < 18) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final isDark = context.watch<ThemeProvider>().isDarkMode;
    final bg = isDark
        ? AppColors.darkBackground
        : const Color(0xFFF6F9FC); // Premium background color

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: bg,
        body: RefreshIndicator(
          onRefresh: _loadData,
          color: const Color(0xFF00BCD4),
          displacement: 60,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(
              parent: BouncingScrollPhysics(),
            ),
            slivers: [
              SliverToBoxAdapter(
                child: Stack(
                  children: [
                    // Top Hero Gradient Background
                    if (!isDark)
                      Container(
                        height: 250,
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color(0xFFF8FCFF), Color(0xFFE9F8FF)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(40),
                            bottomRight: Radius.circular(40),
                          ),
                        ),
                      ),

                    // Main Content
                    SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          HomeHeader(
                            greeting: _greeting,
                            firstName: _firstName,
                          ),
                          const HomeSearchCard(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              const SliverToBoxAdapter(child: HomeQuickActions()),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              if (_isLoading)
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: ShimmerLoading(
                      child: const ShimmerContainer(
                        width: double.infinity,
                        height: 180,
                        borderRadius: 24,
                      ),
                    ),
                  ),
                )
              else
                SliverToBoxAdapter(
                  child: HomePromotionCarousel(promos: _promos),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              if (!_isLoading)
                SliverToBoxAdapter(
                  child: HomePopularRoutes(routes: _popularRoutes),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              if (!_isLoading)
                SliverToBoxAdapter(
                  child: HomeFeaturedDestinations(destinations: _destinations),
                ),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              const SliverToBoxAdapter(child: HomeStatistics()),

              const SliverToBoxAdapter(child: SizedBox(height: 32)),
              const SliverToBoxAdapter(child: HomeReviews()),

              const SliverToBoxAdapter(
                child: SizedBox(height: 120),
              ), // Space for bottom navigation
            ],
          ),
        ),
      ),
    );
  }
}
