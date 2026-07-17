import 'package:busz/models/home_models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter/material.dart';

class SearchHistoryService {
  static final _supabase = Supabase.instance.client;

  static Future<List<SearchHistory>> getHistory() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    try {
      final response = await _supabase
          .from('search_histories')
          .select()
          .eq('user_id', user.id)
          .order('created_at', ascending: false)
          .limit(10);

      return response.map((e) => SearchHistory.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting search history: $e');
      return [];
    }
  }

  static Future<void> saveHistory(SearchHistory history) async {
    final user = _supabase.auth.currentUser;
    if (user == null) return;

    try {
      await _supabase.from('search_histories').insert({
        'user_id': user.id,
        'route_name': history.route,
        'search_date': history.date,
        'passenger_info': history.passengerInfo,
      });
    } catch (e) {
      debugPrint('Error saving search history: $e');
    }
  }
}
