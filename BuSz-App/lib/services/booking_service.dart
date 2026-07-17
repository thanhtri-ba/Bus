import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:busz/providers/booking_provider.dart';

class BookingService {
  static final _supabase = Supabase.instance.client;
  // Use 10.0.2.2 for Android emulator to reach host's localhost
  static const String _baseUrl = 'http://10.0.2.2:3000/api';

  static Future<bool> createBookingAndTicket({
    required String tripScheduleId,
    required List<String> seatNumbers,
    required List<PassengerData> passengers,
  }) async {
    final user = _supabase.auth.currentUser;
    if (user == null) {
      debugPrint('Error: User not logged in');
      return false;
    }

    try {
      final url = Uri.parse('$_baseUrl/bookings');
      final body = {
        'userId': user.id,
        'tripScheduleId': tripScheduleId,
        'seatNumbers': seatNumbers,
        'passengers': passengers
            .map(
              (p) => {
                'name': p.name,
                'idCard': p.idNumber.isNotEmpty ? p.idNumber : null,
              },
            )
            .toList(),
      };

      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        debugPrint(
          'Failed to create booking: ${response.statusCode} - ${response.body}',
        );
        return false;
      }
    } catch (e) {
      debugPrint('Error calling backend booking API: $e');
      return false;
    }
  }
}
