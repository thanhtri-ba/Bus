import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:busz/screens/home/widgets/gogo_home_header.dart'; // Contains TravelEasyHeader
import 'package:busz/screens/home/widgets/gogo_search_card.dart';
import 'package:busz/screens/home/widgets/home_services_section.dart';
import 'package:busz/screens/home/widgets/home_promo_vouchers.dart';
import 'package:busz/screens/home/widgets/home_popular_destinations.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: Colors.transparent, // Dark icons for light background
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFF9FAFB), // Light background
        body: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: SafeArea(
            bottom: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                  child: Column(
                    children: [
                      const TravelEasyHeader(),
                      const SizedBox(height: 24),
                      const GogoSearchCard(),
                    ],
                  ),
                ),
                const SizedBox(height: 32),
                const HomeServicesSection(),
                const SizedBox(height: 32),
                const HomePromoVouchers(),
                const SizedBox(height: 32),
                const HomePopularDestinations(),
                const SizedBox(
                  height: 100,
                ), // Padding at bottom for Bottom Navigation Bar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
