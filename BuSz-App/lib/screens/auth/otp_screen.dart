import 'dart:async';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:busz/services/auth_service.dart';
import 'package:busz/models/response/auth_responses.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String _type = 'email';
  String _value = 'bryanalexander@gmail.com';
  bool _isForgot = false;

  String _otp = '';
  final int _otpLength = 6;
  bool _isLoading = false;

  Timer? _timer;
  int _secondsRemaining = 59;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = GoRouterState.of(context).extra as Map<String, dynamic>?;
    if (args != null) {
      _type = args['type'] as String? ?? 'email';
      _value = args['value'] as String? ?? 'bryanalexander@gmail.com';
      _isForgot = args['forgot'] as bool? ?? false;
    }
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    _secondsRemaining = 59;
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining > 0) {
        setState(() => _secondsRemaining--);
      } else {
        timer.cancel();
      }
    });
  }

  Future<void> _verifyOtp() async {
    if (_otp.length != _otpLength) return;
    setState(() => _isLoading = true);

    BaseResponse response;
    if (_type == 'email') {
      response = await AuthService.verifyEmailOtp(_value, _otp);
    } else {
      response = await AuthService.verifyPhoneOtp(_value, _otp);
    }

    if (!mounted) return;
    setState(() => _isLoading = false);

    if (response.success || _otp == '571234') {
      // Fallback for mock testing
      if (_isForgot) {
        context.pushReplacement(
          '/set-new-password',
          extra: {'type': _type, 'value': _value, 'otp': _otp},
        );
      } else {
        context.pushReplacement(
          '/set-password',
          extra: {'type': _type, 'value': _value},
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Invalid OTP. Hint: use 571234')),
      );
      setState(() => _otp = '');
    }
  }

  void _onKeyPress(String key) {
    if (_isLoading) return;
    if (key == 'backspace') {
      if (_otp.isNotEmpty) {
        setState(() => _otp = _otp.substring(0, _otp.length - 1));
      }
    } else {
      if (_otp.length < _otpLength) {
        setState(() => _otp += key);
        if (_otp.length == _otpLength) {
          _verifyOtp();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surfacePrimary,
      appBar: AppBar(
        backgroundColor: AppColors.surfacePrimary,
        elevation: 0,
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: const Icon(
            Symbols.arrow_back_ios_new_rounded,
            size: 20,
            color: AppColors.textPrimary,
          ),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.xl,
                  vertical: AppSpacing.xs,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _type == 'email'
                          ? 'Verify your email'
                          : 'Verify your phone number',
                      style: AppTextStyles.headline,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Text(
                      'Enter the verification code sent to',
                      style: AppTextStyles.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _value,
                            style: AppTextStyles.bodyMedium.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () => context.pop(),
                          child: Text(
                            _type == 'email' ? 'Change email' : 'Change phone',
                            style: AppTextStyles.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: List.generate(_otpLength, (index) {
                        return _buildOtpBox(index);
                      }),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Resend in $_secondsRemaining s',
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: _secondsRemaining > 0
                                ? AppColors.textHint
                                : AppColors.primary,
                            fontWeight: _secondsRemaining > 0
                                ? FontWeight.normal
                                : FontWeight.w600,
                          ),
                        ),
                        Text(
                          'Get help',
                          style: AppTextStyles.bodyMedium.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            _buildCustomNumpad(),
          ],
        ),
      ),
    );
  }

  Widget _buildOtpBox(int index) {
    bool isFocused = _otp.length == index;
    bool hasValue = index < _otp.length;

    return Container(
      width: 48,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(
          color: isFocused ? AppColors.primary : AppColors.borderNormal,
          width: isFocused ? 1.5 : 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Center(
        child: _isLoading && isFocused
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primary,
                ),
              )
            : Text(
                hasValue ? _otp[index] : (isFocused ? '|' : ''),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isFocused ? AppColors.primary : AppColors.textPrimary,
                ),
              ),
      ),
    );
  }

  Widget _buildCustomNumpad() {
    return Container(
      color: const Color(0xFFD1D5DB), // iOS keyboard grey background
      padding: const EdgeInsets.only(bottom: 24, top: 6, left: 6, right: 6),
      child: Column(
        children: [
          Row(
            children: [
              _buildKey('1', ''),
              _buildKey('2', 'A B C'),
              _buildKey('3', 'D E F'),
            ],
          ),
          Row(
            children: [
              _buildKey('4', 'G H I'),
              _buildKey('5', 'J K L'),
              _buildKey('6', 'M N O'),
            ],
          ),
          Row(
            children: [
              _buildKey('7', 'P Q R S'),
              _buildKey('8', 'T U V'),
              _buildKey('9', 'W X Y Z'),
            ],
          ),
          Row(
            children: [
              Expanded(child: const SizedBox()), // Empty slot
              _buildKey('0', ''),
              Expanded(
                child: GestureDetector(
                  onTap: () => _onKeyPress('backspace'),
                  child: Container(
                    height: 54,
                    margin: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(
                        0xFFBCC0C6,
                      ), // slightly darker grey for backspace
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: const Center(
                      child: Icon(
                        Symbols.backspace_rounded,
                        color: Color(0xFF0F172A),
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildKey(String number, String letters) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onKeyPress(number),
        child: Container(
          height: 54,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.3),
                blurRadius: 0,
                offset: const Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                number,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.normal,
                  color: Colors.black,
                ),
              ),
              if (letters.isNotEmpty)
                Text(
                  letters,
                  style: const TextStyle(
                    fontSize: 8,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
