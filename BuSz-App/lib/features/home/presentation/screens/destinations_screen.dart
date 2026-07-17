import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';

class DestinationsScreen extends StatelessWidget {
  const DestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final destinations = [
      {
        'name': 'Đà Lạt',
        'desc': 'Thành phố ngàn hoa',
        'trips': '120 chuyến/ngày',
      },
      {
        'name': 'Nha Trang',
        'desc': 'Biển xanh cát trắng',
        'trips': '85 chuyến/ngày',
      },
      {
        'name': 'Sapa',
        'desc': 'Thị trấn trong sương',
        'trips': '40 chuyến/ngày',
      },
      {
        'name': 'Vũng Tàu',
        'desc': 'Điểm đến cuối tuần',
        'trips': '200 chuyến/ngày',
      },
      {
        'name': 'Đà Nẵng',
        'desc': 'Thành phố đáng sống',
        'trips': '90 chuyến/ngày',
      },
      {'name': 'Hội An', 'desc': 'Phố cổ yên bình', 'trips': '30 chuyến/ngày'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Điểm đến Phổ biến'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: AppSpacing.md,
          crossAxisSpacing: AppSpacing.md,
          childAspectRatio: 0.8,
        ),
        itemCount: destinations.length,
        itemBuilder: (context, index) {
          final dest = destinations[index];
          return GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: AppRadius.largeAll,
              ),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: AppRadius.largeAll,
                    ),
                    child: const Icon(
                      Symbols.image_rounded,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: AppRadius.largeAll,
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.8),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: AppSpacing.md,
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          dest['name']!,
                          style: AppTextStyles.titleMedium.copyWith(
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          dest['desc']!,
                          style: AppTextStyles.captionSmall.copyWith(
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: AppRadius.smallAll,
                          ),
                          child: Text(
                            dest['trips']!,
                            style: AppTextStyles.captionSmall.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
