import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class GogoHistorySection extends StatelessWidget {
  const GogoHistorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              const Text(
                'History',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Color(0xFF101828),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F4F7),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Text(
                  '0',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                    color: Color(0xFF344054),
                  ),
                ),
              ),
              const Spacer(),
              const Text(
                'View All',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w700,
                  fontSize: 12,
                  color: Color(0xFF072C34),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Symbols.chevron_right_rounded,
                color: Color(0xFF072C34),
                size: 16,
                weight: 600,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Image.asset(
            'assets/images/empty_history_folder.png',
            width: 120,
            height: 120,
          ),
          const SizedBox(height: 24),
          const Text(
            'There is nothing here.',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 16,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You do not have any trip history yet, please fill out\nthe form above to start purchasing bus tickets.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.5,
              color: const Color(0xFF667085).withValues(alpha: 0.8),
            ),
          ),
          const SizedBox(height: 48),
        ],
      ),
    );
  }
}
