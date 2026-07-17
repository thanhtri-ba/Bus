import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/router/route_names.dart';

class SavedDestinationList extends StatelessWidget {
  const SavedDestinationList({super.key});

  final List<String> _mockDestinations = const [
    'Pantai Indah Kapuk',
    'Central Park Mall',
    'Soekarno-Hatta Int',
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60, // approximate height for the card
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        scrollDirection: Axis.horizontal,
        itemCount: _mockDestinations.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final destination = _mockDestinations[index];
          return GestureDetector(
            onTap: () => context.push(RouteNames.intercitySearch),
            child: Container(
              width: 160,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F4F7),
                border: Border.all(color: const Color(0xFFEAECF0)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Buy ticket to',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      const Icon(
                        Symbols.location_on_rounded,
                        size: 16,
                        color: Color(0xFF101828),
                      ),
                      const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          destination,
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                            height: 1.5,
                            color: Color(0xFF101828),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
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
