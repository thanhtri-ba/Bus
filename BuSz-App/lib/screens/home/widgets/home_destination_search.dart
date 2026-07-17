import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/router/route_names.dart';

class HomeDestinationSearch extends StatelessWidget {
  const HomeDestinationSearch({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: GestureDetector(
        onTap: () => context.push(RouteNames.intercitySearch),
        child: Container(
          width: double.infinity,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: const Color(0xFFEAECF0),
            ), // lighter border
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF101828).withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: const Text(
            'Where are you going today?',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 14,
              height: 1.42, // 20 / 14
              color: Color(0xFF344054),
            ),
          ),
        ),
      ),
    );
  }
}
