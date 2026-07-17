import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_spacing.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String? errorText;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onCountryCodeChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    this.errorText,
    this.onChanged,
    this.onCountryCodeChanged,
  });

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  String _countryCode = '+62';

  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorText != null && widget.errorText!.isNotEmpty;
    // Use an explicit border color for normal state since AppColors.borderPrimary might be missing
    final borderColor = hasError
        ? AppColors.borderError
        : const Color(0xFFD0D5DD);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 40,
          decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(8),
            color: Colors.white,
          ),
          child: Row(
            children: [
              // Country Code
              InkWell(
                onTap: () async {
                  final result = await context.push<String>(
                    RouteNames.countryCode,
                  );
                  if (result != null && result.isNotEmpty) {
                    setState(() {
                      _countryCode = result;
                    });
                    if (widget.onCountryCodeChanged != null) {
                      widget.onCountryCodeChanged!(_countryCode);
                    }
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      Text(
                        _countryCode,
                        style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF344054),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Color(0xFF344054),
                        size: 20,
                      ),
                    ],
                  ),
                ),
              ),
              // Divider
              Container(
                width: 1,
                height: double.infinity,
                color: const Color(0xFFD0D5DD),
              ),
              // Input Field
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  keyboardType: TextInputType.phone,
                  onChanged: widget.onChanged,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    height: 24 / 16,
                    color: Color(0xFF344054),
                  ),
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.only(left: 12, bottom: 10),
                    hintText: '82198761234',
                    hintStyle: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 16,
                      color: Color(0xFFD0D5DD),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (hasError)
          Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Text(
              widget.errorText!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                color: AppColors.textError,
              ),
            ),
          ),
      ],
    );
  }
}
