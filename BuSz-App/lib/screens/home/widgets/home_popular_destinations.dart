import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';

class HomePopularDestinations extends StatelessWidget {
  const HomePopularDestinations({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Tuyến đường phổ biến',
            style: TextStyle(
              fontFamily: 'Inter',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _buildRouteCard(
                imagePath:
                    'https://images.unsplash.com/photo-1583417319070-4a69db38a482?q=80&w=200&auto=format&fit=crop', // Da Lat placeholder
                from: 'Sài Gòn',
                to: 'Đà Lạt',
                distance: '300km',
                time: '6 giờ',
                info: 'Hàng ngày\n24/24',
                price: '300.000đ',
              ),
              const SizedBox(height: 16),
              _buildRouteCard(
                imagePath:
                    'https://images.unsplash.com/photo-1528127269322-539801943592?q=80&w=200&auto=format&fit=crop', // Sapa placeholder
                from: 'Hà Nội',
                to: 'Sapa',
                distance: '320km',
                time: '5.5 giờ',
                info: 'Xe giường nằm',
                price: '350.000đ',
              ),
              const SizedBox(height: 16),
              _buildRouteCard(
                imagePath:
                    'https://images.unsplash.com/photo-1559592413-7cea4ee85f1c?q=80&w=200&auto=format&fit=crop', // Da Nang placeholder
                from: 'Đà Nẵng',
                to: 'Huế',
                distance: '100km',
                time: '2 giờ',
                info: 'Limousine cao cấp',
                price: '150.000đ',
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRouteCard({
    required String imagePath,
    required String from,
    required String to,
    required String distance,
    required String time,
    required String info,
    required String price,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderNormal),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              imagePath,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 80,
                height: 80,
                color: AppColors.gray200,
                child: const Icon(
                  Symbols.image_rounded,
                  color: AppColors.gray400,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      from,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        Symbols.arrow_right_alt_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    Text(
                      to,
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: AppColors.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(
                      Symbols.location_on_rounded,
                      size: 12,
                      color: AppColors.textSecondary,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '$distance • $time',
                      style: const TextStyle(
                        fontFamily: 'Inter',
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Text(
                        info,
                        style: const TextStyle(
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          fontSize: 10,
                          color: AppColors.secondary,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        const Text(
                          'từ',
                          style: TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            fontSize: 10,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        Text(
                          price,
                          style: const TextStyle(
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                            color: Color(0xFFF79009), // Orange
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
