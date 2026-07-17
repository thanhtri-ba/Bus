/// BusZ — Passenger Information Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/07_Booking_Module.md §8
///
/// For each selected seat, user enters:
/// - Full Name (required)
/// - Phone Number (required)
/// - Identity Number (CCCD/Passport, required)
/// - Email (optional)
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';

class PassengerInfoScreen extends StatefulWidget {
  const PassengerInfoScreen({super.key});

  @override
  State<PassengerInfoScreen> createState() => _PassengerInfoScreenState();
}

class _PassengerInfoScreenState extends State<PassengerInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  late int _seatCount;
  late final List<_PassengerFormData> _passengers;
  final _scrollController = ScrollController();
  // Contact info controllers
  final _contactEmailController = TextEditingController();
  final _contactPhoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Read seat count from provider
    final booking = context.read<BookingProvider>();
    _seatCount = booking.seatCount > 0 ? booking.seatCount : 1;
    _passengers = List.generate(_seatCount, (i) => _PassengerFormData());
  }

  @override
  void dispose() {
    for (final p in _passengers) {
      p.dispose();
    }
    _contactEmailController.dispose();
    _contactPhoneController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thông tin hành khách'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          controller: _scrollController,
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            // Contact Info Section
            Text('Thông tin liên hệ', style: AppTextStyles.titleSmall),
            const SizedBox(height: AppSpacing.xs),
            Text(
              'Thông tin này sẽ được dùng để gửi vé điện tử.',
              style: AppTextStyles.bodySmall,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email',
                hintText: 'example@email.com',
                prefixIcon: Icon(Symbols.email_rounded),
              ),
              keyboardType: TextInputType.emailAddress,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Vui lòng nhập email';
                if (!v.contains('@')) return 'Email không hợp lệ';
                return null;
              },
            ),
            const SizedBox(height: AppSpacing.sm),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                hintText: '0912 345 678',
                prefixIcon: Icon(Symbols.phone_rounded),
              ),
              keyboardType: TextInputType.phone,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Vui lòng nhập số điện thoại';
                }
                return null;
              },
            ),

            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            const SizedBox(height: AppSpacing.md),

            // Passenger forms
            ...List.generate(_seatCount, (index) {
              return _buildPassengerForm(index);
            }),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Save passenger info to provider
                final passengerList = _passengers
                    .map(
                      (p) => PassengerData(
                        name: p.nameController.text,
                        phone: p.phoneController.text,
                        idNumber: p.idController.text,
                        email: p.emailController.text,
                      ),
                    )
                    .toList();

                context.read<BookingProvider>().setContactInfo(
                  name: _passengers.first.nameController.text,
                  phone: _contactPhoneController.text.isEmpty
                      ? _passengers.first.phoneController.text
                      : _contactPhoneController.text,
                  email: _contactEmailController.text,
                );
                context.read<BookingProvider>().setPassengers(passengerList);

                context.push(RouteNames.bookingSummary);
              }
            },
            child: const Text('Tiếp tục'),
          ),
        ),
      ),
    );
  }

  Widget _buildPassengerForm(int index) {
    final p = _passengers[index];
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  'Ghế ${index + 1}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              Text('Hành khách ${index + 1}', style: AppTextStyles.titleSmall),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          TextFormField(
            controller: p.nameController,
            decoration: const InputDecoration(
              labelText: 'Họ và tên *',
              hintText: 'Nguyễn Văn A',
              prefixIcon: Icon(Symbols.person_rounded),
            ),
            textCapitalization: TextCapitalization.words,
            validator: (v) =>
                v == null || v.isEmpty ? 'Vui lòng nhập họ tên' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: p.phoneController,
            decoration: const InputDecoration(
              labelText: 'Số điện thoại *',
              hintText: '0912 345 678',
              prefixIcon: Icon(Symbols.phone_rounded),
            ),
            keyboardType: TextInputType.phone,
            validator: (v) =>
                v == null || v.isEmpty ? 'Vui lòng nhập số điện thoại' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: p.idController,
            decoration: const InputDecoration(
              labelText: 'CCCD / Hộ chiếu *',
              hintText: '001234567890',
              prefixIcon: Icon(Symbols.badge_rounded),
            ),
            validator: (v) =>
                v == null || v.isEmpty ? 'Vui lòng nhập CCCD/Hộ chiếu' : null,
          ),
          const SizedBox(height: AppSpacing.sm),
          TextFormField(
            controller: p.emailController,
            decoration: const InputDecoration(
              labelText: 'Email (không bắt buộc)',
              hintText: 'example@email.com',
              prefixIcon: Icon(Symbols.email_rounded),
            ),
            keyboardType: TextInputType.emailAddress,
          ),
        ],
      ),
    );
  }
}

class _PassengerFormData {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final idController = TextEditingController();
  final emailController = TextEditingController();

  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    idController.dispose();
    emailController.dispose();
  }
}
