import 'package:busz/models/home_models.dart';

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserService {
  static final _supabase = Supabase.instance.client;

  static Future<UserProfile> getProfile() async {
    try {
      final user = _supabase.auth.currentUser;
      if (user == null) return UserProfile(name: 'Khách', dob: '');

      final data = await _supabase
          .from('User')
          .select('fullName')
          .eq('id', user.id)
          .maybeSingle();

      if (data != null && data['fullName'] != null) {
        return UserProfile(name: data['fullName'] as String, dob: '');
      }
      return UserProfile(
        name: user.email?.split('@').first ?? 'Người dùng BusZ',
        dob: '',
      );
    } catch (e) {
      debugPrint('Error fetching profile: $e');
      return UserProfile(name: 'Người dùng BusZ', dob: '');
    }
  }
}
