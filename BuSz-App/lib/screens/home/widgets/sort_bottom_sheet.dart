import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class SortBottomSheet extends StatefulWidget {
  const SortBottomSheet({super.key});

  @override
  State<SortBottomSheet> createState() => _SortBottomSheetState();
}

class _SortBottomSheetState extends State<SortBottomSheet> {
  final List<String> _sortOptions = [
    'Earliest departure time',
    'Price Low to High',
    'Earliest arrival time',
    'Shortest travel time',
    'Highest Rating',
  ];
  String _selectedOption = 'Earliest departure time';

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
                    'Sort',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 48), // balance
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: _sortOptions.map((e) => _buildRadioItem(e)).toList(),
              ),
            ),

            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  Widget _buildRadioItem(String title) {
    return InkWell(
      onTap: () {
        setState(() => _selectedOption = title);
        Future.delayed(const Duration(milliseconds: 200), () {
          if (!mounted) return;
          Navigator.pop(context, title);
        });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: _selectedOption == title
                      ? const Color(0xFF1A7F8E)
                      : Colors.grey[300]!,
                  width: _selectedOption == title ? 7 : 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
