import 'package:busz/models/home_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class LoyaltyService {
  static final _supabase = Supabase.instance.client;

  static Future<Loyalty> getLoyalty() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return Loyalty(points: 0, tierName: 'Thành Viên Mới');

    try {
      final response = await _supabase
          .from('loyalty')
          .select()
          .eq('userId', user.id)
          .maybeSingle();

      if (response == null)
        return Loyalty(points: 0, tierName: 'Thành Viên Mới');
      return Loyalty.fromJson(response);
    } catch (e) {
      debugPrint('Error getting loyalty: $e');
      return Loyalty(points: 0, tierName: 'Thành Viên Mới');
    }
  }
}
