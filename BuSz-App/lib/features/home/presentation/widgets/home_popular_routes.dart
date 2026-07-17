import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:busz/providers/theme_provider.dart';

class HomePopularRoutes extends StatelessWidget {
  final List<Map<String, dynamic>> routes;

  const HomePopularRoutes({super.key, required this.routes});

  @override
  Widget build(BuildContext context) {
    if (routes.isEmpty) return const SizedBox.shrink();

    final isDark = context.watch<ThemeProvider>().isDarkMode;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Popular Routes',
                style: TextStyle(
                  fontFamily: 'Inter',
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: isDark ? Colors.white : const Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 160,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            itemCount: routes.length,
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemBuilder: (context, index) {
              final route = routes[index];
              final rPrice = route['basePrice'] != null
                  ? '${(route['basePrice'] as num) ~/ 1000}k'
                  : 'N/A';
              final durationMins = route['durationMins'] as num?;
              final rDuration = durationMins != null
                  ? '${durationMins ~/ 60}h ${durationMins % 60}m'
                  : 'N/A';
              final rFrom = route['departureCity'] ?? 'Origin';
              final rTo = route['arrivalCity'] ?? 'Destination';

              // Fallback for fields not strictly in current mock data
              final companyLogo = route['companyLogo'] as String? ?? '';
              final remainingSeats =
                  route['remainingSeats'] as int? ?? 12; // fallback

              return _buildRouteCard(
                context: context,
                from: rFrom,
                to: rTo,
                duration: rDuration,
                price: rPrice,
                logoUrl: companyLogo,
                remainingSeats: remainingSeats,
                isDark: isDark,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildRouteCard({
    required BuildContext context,
    required String from,
    required String to,
    required String duration,
    required String price,
    required String logoUrl,
    required int remainingSeats,
    required bool isDark,
  }) {
    return GestureDetector(
      onTap: () {
        context.read<BookingProvider>().setSearch(
          departure: from,
          destination: to,
          date: 'Hôm nay',
        );
        context.push(RouteNames.searchResults);
      },
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isDark ? AppColors.darkCard : Colors.white,
          borderRadius: BorderRadius.circular(22),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.04),
              blurRadius: 24,
              offset: const Offset(0, 12),
            ),
          ],
          border: Border.all(
            color: isDark ? Colors.white12 : const Color(0xFFE5E7EB),
          ),
        ),
        child: Column(
          children: [
            // Top Row: Logo & Price
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF6F9FC),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: logoUrl.isNotEmpty
                          ? Image.network(logoUrl, fit: BoxFit.cover)
                          : const Icon(
                              Symbols.directions_bus_rounded,
                              size: 18,
                              color: Color(0xFF0097A7),
                            ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'BusZ Express', // Fallback company name
                      style: TextStyle(
                        fontFamily: 'Inter',
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isDark
                            ? AppColors.darkTextSecondary
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
                Text(
                  price,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF00BCD4),
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Middle Row: Route & Duration
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    from,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    children: [
                      const Icon(
                        Symbols.arrow_forward_rounded,
                        size: 16,
                        color: Color(0xFF64748B),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        duration,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontSize: 10,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF64748B),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Text(
                    to,
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: isDark ? Colors.white : const Color(0xFF0F172A),
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            // Bottom Row: Seats & Favorite
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00BCD4).withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    '$remainingSeats seats left',
                    style: const TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0097A7),
                    ),
                  ),
                ),
                Icon(
                  Symbols.favorite_border_rounded,
                  size: 20,
                  color: isDark
                      ? AppColors.darkTextSecondary
                      : const Color(0xFF64748B),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
