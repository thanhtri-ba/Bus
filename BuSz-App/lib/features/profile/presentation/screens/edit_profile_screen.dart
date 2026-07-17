/// BusZ — Edit Profile Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/10_Profile_Module.md §5
library;

import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sửa hồ sơ'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.md),
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: AppColors.primaryLight,
                    child: Text(
                      'A',
                      style: AppTextStyles.displayLarge.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                        border: Border.all(color: AppColors.white, width: 2),
                      ),
                      child: const Icon(
                        Symbols.camera_alt_rounded,
                        size: 16,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),

            TextFormField(
              initialValue: 'Nguyễn Văn A',
              decoration: const InputDecoration(
                labelText: 'Họ và tên',
                prefixIcon: Icon(Symbols.person_rounded),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              initialValue: '0912 345 678',
              decoration: const InputDecoration(
                labelText: 'Số điện thoại',
                prefixIcon: Icon(Symbols.phone_rounded),
              ),
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              initialValue: 'example@email.com',
              decoration: const InputDecoration(
                labelText: 'Email',
                prefixIcon: Icon(Symbols.email_rounded),
              ),
              enabled: false,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ngày sinh',
                prefixIcon: Icon(Symbols.calendar_today_rounded),
              ),
              readOnly: true,
              onTap: () {},
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.md),
          child: ElevatedButton(
            onPressed: () => context.pop(),
            child: const Text('Lưu thay đổi'),
          ),
        ),
      ),
    );
  }
}
