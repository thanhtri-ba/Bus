import 'package:flutter/material.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

class AppCheckbox extends StatelessWidget {
  final bool value;
  final ValueChanged<bool?> onChanged;
  final String? label;

  const AppCheckbox({
    super.key,
    required this.value,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    Widget checkbox = Checkbox(
      value: value,
      onChanged: onChanged,
      activeColor: AppColors.backgroundBrand,
      checkColor: AppColors.textWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      side: const BorderSide(color: AppColors.borderPrimary),
    );

    if (label != null) {
      return GestureDetector(
        onTap: () => onChanged(!value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            checkbox,
            const SizedBox(width: AppSpacing.xxs),
            Text(
              label!,
              style: AppTextStyles.textMediumRegular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }
    return checkbox;
  }
}

class AppRadio<T> extends StatelessWidget {
  final T value;
  final T groupValue;
  final ValueChanged<T?> onChanged;
  final String? label;

  const AppRadio({
    super.key,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    this.label,
  });

  @override
  Widget build(BuildContext context) {
    Widget radio = Radio<T>(
      value: value,
      // ignore: deprecated_member_use
      groupValue: groupValue,
      // ignore: deprecated_member_use
      onChanged: onChanged,
      activeColor: AppColors.backgroundBrand,
    );

    if (label != null) {
      return GestureDetector(
        onTap: () => onChanged(value),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            radio,
            const SizedBox(width: AppSpacing.xxs),
            Text(
              label!,
              style: AppTextStyles.textMediumRegular.copyWith(
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      );
    }
    return radio;
  }
}
