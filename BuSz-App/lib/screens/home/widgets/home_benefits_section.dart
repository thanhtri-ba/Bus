import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

class HomeBenefitsSection extends StatelessWidget {
  const HomeBenefitsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Why Choose Us',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF101828),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              _buildBenefitRow(
                icon: Symbols.wifi_rounded,
                title: 'Free Wi-Fi',
                subtitle: 'Stay connected during your journey',
                iconColor: const Color(0xFF1570EF),
                bgColor: const Color(0xFFEFF8FF),
              ),
              const SizedBox(height: 12),
              _buildBenefitRow(
                icon: Symbols.event_seat_rounded,
                title: 'Premium Seats',
                subtitle: 'Comfortable and spacious legroom',
                iconColor: const Color(0xFFF79009),
                bgColor: const Color(0xFFFFFAEB),
              ),
              const SizedBox(height: 12),
              _buildBenefitRow(
                icon: Symbols.support_agent_rounded,
                title: '24/7 Support',
                subtitle: 'We are here to help anytime',
                iconColor: const Color(0xFF12B76A),
                bgColor: const Color(0xFFECFDF3),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBenefitRow({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color iconColor,
    required Color bgColor,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFEAECF0)),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF101828).withValues(alpha: 0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: bgColor, shape: BoxShape.circle),
            child: Icon(icon, color: iconColor, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Color(0xFF101828),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                    color: Color(0xFF667085),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
