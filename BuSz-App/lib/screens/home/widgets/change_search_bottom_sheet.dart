import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/screens/home/widgets/home_search_card.dart';

class ChangeSearchBottomSheet extends StatelessWidget {
  const ChangeSearchBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Symbols.close_rounded,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Change Search',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 48), // balance
                ],
              ),
            ),

            // Reusing the Search Card UI but without the heavy shadow
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: HomeSearchCard(
                onSearch: () {
                  Navigator.pop(context);
                },
                onSelectFrom: () {
                  // handle navigation
                },
                onSelectTo: () {
                  // handle navigation
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
