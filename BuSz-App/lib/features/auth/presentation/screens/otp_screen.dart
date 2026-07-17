import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/components/app_header.dart';
import 'package:busz/features/auth/domain/providers/auth_state_provider.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String phone;

  const OtpScreen({super.key, required this.phone});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  bool _isLoading = false;
  bool _isError = false;
  int _secondsRemaining =
      0; // Starts with Resend available in mockup initially, but let's do 60s for real behavior
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    // Defaulting to "Resend" state first as in Figma screenshot 2 (or countdown in screenshot 4).
    // Let's start with 0 so "Resend" is shown.
    _secondsRemaining = 0;
  }

  void _startTimer() {
    setState(() {
      _secondsRemaining = 59;
      _isError = false;
    });
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    super.dispose();
  }

  void _verifyOtp(String otp) async {
    if (otp.length != 4) return;

    setState(() {
      _isLoading = true;
      _isError = false;
    });

    // Simulate API call
    await Future.delayed(const Duration(milliseconds: 1500));

    if (!mounted) return;

    // Figma Fake Logic for testing error
    if (otp == '2457') {
      setState(() {
        _isLoading = false;
        _isError = true;
      });
      return;
    }

    // Success condition
    ref.read(authStateProvider.notifier).login();
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 60,
      height: 64,
      textStyle: AppTextStyles.displayXSSemiBold.copyWith(
        color: AppColors.textPrimary,
      ),
      decoration: BoxDecoration(
        color: AppColors.backgroundPrimary,
        border: Border.all(color: AppColors.borderSecondary),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.borderBrand),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppColors.borderError),
    );

    return Scaffold(
      backgroundColor: AppColors.backgroundPrimary,
      appBar: const AppHeader(title: ''),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: AppSpacing.xxl),

              Text(
                'Input Verification Code',
                textAlign: TextAlign.center,
                style: AppTextStyles.displayXSSemiBold.copyWith(
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                'We have sent code to your phone number\n${widget.phone}',
                textAlign: TextAlign.center,
                style: AppTextStyles.textMediumRegular.copyWith(
                  color: AppColors.textTertiary,
                ),
              ),
              const SizedBox(height: AppSpacing.xxxl),

              // OTP Input
              Center(
                child: Pinput(
                  controller: _otpController,
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  errorPinTheme: errorPinTheme,
                  forceErrorState: _isError,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: _verifyOtp,
                  onChanged: (val) {
                    if (_isError) setState(() => _isError = false);
                  },
                ),
              ),

              const SizedBox(height: AppSpacing.xxxl),

              // Resend / Countdown
              Center(
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : RichText(
                        text: TextSpan(
                          text: "Didn't receive code? ",
                          style: AppTextStyles.textSmallMedium.copyWith(
                            color: AppColors.textTertiary,
                          ),
                          children: [
                            if (_secondsRemaining > 0)
                              TextSpan(
                                text:
                                    '00:${_secondsRemaining.toString().padLeft(2, '0')}',
                                style: AppTextStyles.textSmallMedium.copyWith(
                                  color: AppColors.textTertiary,
                                ),
                              )
                            else
                              TextSpan(
                                text: 'Resend',
                                style: AppTextStyles.textSmallSemiBold.copyWith(
                                  color: const Color(0xFF1877F2), // Brand Blue
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _startTimer,
                              ),
                          ],
                        ),
                      ),
              ),

              const Spacer(),

              // Error Banner
              if (_isError)
                Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.xl),
                  padding: const EdgeInsets.symmetric(
                    vertical: 16,
                    horizontal: AppSpacing.lg,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.error, // Red background
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Verification code incorrect',
                    style: AppTextStyles.textMediumMedium.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
