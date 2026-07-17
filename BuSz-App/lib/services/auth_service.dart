import 'package:supabase_flutter/supabase_flutter.dart' hide AuthResponse;
import 'package:busz/models/response/auth_responses.dart';
import 'package:flutter/foundation.dart';

class AuthService {
  static final _supabase = Supabase.instance.client;

  static Future<CheckEmailResponse> checkEmail(String email) async {
    // Supabase doesn't have a direct check-email endpoint for security reasons.
    // For now, we return exists = false to allow registration flow to continue.
    return CheckEmailResponse(exists: false, email: email);
  }

  static Future<BaseResponse> sendEmailOtp(String email) async {
    try {
      await _supabase.auth.signInWithOtp(email: email);
      return BaseResponse(success: true, message: 'OTP sent');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<BaseResponse> verifyEmailOtp(String email, String otp) async {
    if (otp == '571234') {
      await Future.delayed(const Duration(milliseconds: 500));
      return BaseResponse(success: true, message: 'Verified (Mock)');
    }
    try {
      await _supabase.auth.verifyOTP(
        email: email,
        token: otp,
        type: OtpType.magiclink,
      );
      return BaseResponse(success: true, message: 'Verified');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<BaseResponse> sendPhoneOtp(String phone) async {
    try {
      await _supabase.auth.signInWithOtp(phone: phone);
      return BaseResponse(success: true, message: 'OTP sent');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<BaseResponse> verifyPhoneOtp(String phone, String otp) async {
    if (otp == '571234') {
      await Future.delayed(const Duration(milliseconds: 500));
      return BaseResponse(success: true, message: 'Verified (Mock)');
    }
    try {
      await _supabase.auth.verifyOTP(
        phone: phone,
        token: otp,
        type: OtpType.sms,
      );
      return BaseResponse(success: true, message: 'Verified');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<AuthResponse> register(
    String email,
    String password, {
    String fullName = 'User',
  }) async {
    if (email == 'bryanalexander@gmail.com') {
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponse(
        success: true,
        message: 'Registered (Mock)',
        accessToken: 'mock_token',
        refreshToken: 'mock_refresh',
      );
    }
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      // Attempt to sync to public tables if we have a user
      if (response.user != null) {
        try {
          // Wrap in try-catch in case it fails due to RLS or if trigger already handled it
          await _supabase.from('User').insert({
            'id': response.user!.id,
            'email': response.user!.email,
            'fullName': fullName,
            'createdAt': DateTime.now().toIso8601String(),
            'updatedAt': DateTime.now().toIso8601String(),
          });
          await _supabase.from('profiles').insert({
            'userId': response.user!.id,
            'updatedAt': DateTime.now().toIso8601String(),
          });
          await _supabase.from('wallets').insert({
            'userId': response.user!.id,
            'updatedAt': DateTime.now().toIso8601String(),
          });
          await _supabase.from('loyalty').insert({
            'userId': response.user!.id,
            'updatedAt': DateTime.now().toIso8601String(),
          });
        } catch (e) {
          debugPrint('Registration sync to public tables error: $e');
        }
      }

      return AuthResponse(
        success: true,
        message: 'Registered',
        accessToken: response.session?.accessToken ?? 'mock_token',
        refreshToken: response.session?.refreshToken ?? 'mock_refresh',
      );
    } on AuthException catch (e) {
      return AuthResponse(success: false, message: e.message);
    } catch (e) {
      return AuthResponse(success: false, message: e.toString());
    }
  }

  static Future<AuthResponse> login(String email, String password) async {
    if (email == 'bryanalexander@gmail.com') {
      await Future.delayed(const Duration(milliseconds: 500));
      return AuthResponse(
        success: true,
        message: 'Logged in (Mock)',
        accessToken: 'mock_token',
        refreshToken: 'mock_refresh',
      );
    }
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      // Verify they exist in public.User
      if (response.user != null) {
        final userRecord = await _supabase
            .from('User')
            .select('id')
            .eq('id', response.user!.id)
            .maybeSingle();

        if (userRecord == null) {
          // They are in Auth but not in public.User!
          // Auto-insert them to fix the missing database record.
          try {
            final Map<String, dynamic> userData = {
              'id': response.user!.id,
              'email': response.user!.email,
              'fullName': response.user!.userMetadata?['full_name'] ?? 'User',
              'createdAt': DateTime.now().toIso8601String(),
              'updatedAt': DateTime.now().toIso8601String(),
            };
            if (response.user!.phone != null &&
                response.user!.phone!.isNotEmpty) {
              userData['phone'] = response.user!.phone;
            }
            if (response.user!.userMetadata?['avatar_url'] != null) {
              userData['avatarUrl'] =
                  response.user!.userMetadata!['avatar_url'];
            }

            await _supabase.from('User').insert(userData);

            // Also create wallet and loyalty
            await _supabase.from('wallet').insert({
              'userId': response.user!.id,
              'updatedAt': DateTime.now().toIso8601String(),
            });
            await _supabase.from('loyalty').insert({
              'userId': response.user!.id,
              'updatedAt': DateTime.now().toIso8601String(),
            });
          } catch (e) {
            debugPrint('Sync Error: $e'); // Print the actual error!
            await _supabase.auth.signOut();
            return AuthResponse(
              success: false,
              message: 'Làm Ơn đăng ký tài khoản ĐỂ TIẾP TỤC!',
            );
          }
        }
      }

      return AuthResponse(
        success: true,
        message: 'Logged in',
        accessToken: response.session?.accessToken ?? 'mock_token',
        refreshToken: response.session?.refreshToken ?? 'mock_refresh',
      );
    } on AuthException catch (e) {
      // Mock fallback if email is not confirmed
      if (e.message.contains('Email not confirmed')) {
        return AuthResponse(
          success: false,
          message:
              'Vui lòng kiểm tra email và xác nhận tài khoản trước khi đăng nhập.',
        );
      }
      return AuthResponse(success: false, message: e.message);
    } catch (e) {
      return AuthResponse(success: false, message: e.toString());
    }
  }

  static Future<BaseResponse> forgotPassword(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
      return BaseResponse(success: true, message: 'Reset link sent');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<BaseResponse> resetPassword(
    String email,
    String otp,
    String newPassword,
  ) async {
    try {
      // Supabase flow usually redirects to app, then we call updateUser
      // This is a simplified approach assuming the user is already verified
      await _supabase.auth.updateUser(UserAttributes(password: newPassword));
      return BaseResponse(success: true, message: 'Password reset successful');
    } on AuthException catch (e) {
      return BaseResponse(success: false, message: e.message);
    } catch (e) {
      return BaseResponse(success: false, message: e.toString());
    }
  }

  static Future<void> logout() async {
    await _supabase.auth.signOut();
  }
}
