import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:busz/models/home_models.dart';

class TicketService {
  static final _supabase = Supabase.instance.client;
  static const String _offlineBox = 'offline_tickets_box';

  static Future<bool> _hasNetwork() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  static Future<List<Ticket>> getMyTickets() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return [];

    final box = await Hive.openBox(_offlineBox);

    if (await _hasNetwork()) {
      try {
        final response = await _supabase
            .from('tickets')
            .select(
              '*, Booking!inner(*, TripSchedule(*, Trip:trips(*, busAgent:bus_agents(*), Route(*, departureCity:cities!Route_departureCityId_fkey(name), arrivalCity:cities!Route_arrivalCityId_fkey(name))))), Passenger(*)',
            )
            .eq('Booking.userId', user.id)
            .order('createdAt', ascending: false);

        final tickets = response.map((e) => Ticket.fromJson(e)).toList();

        // Cache tickets for offline use
        await box.clear();
        for (var t in tickets) {
          await box.put(t.id, t.toJson());
        }

        return tickets;
      } catch (e) {
        debugPrint('Error fetching tickets online, falling back to cache: $e');
        return _getOfflineTickets(box);
      }
    } else {
      // Offline mode
      return _getOfflineTickets(box);
    }
  }

  static List<Ticket> _getOfflineTickets(Box box) {
    if (box.isEmpty) return [];
    try {
      final tickets = <Ticket>[];
      for (var key in box.keys) {
        final Map<dynamic, dynamic> rawMap = box.get(key);
        // Convert Map<dynamic, dynamic> to Map<String, dynamic> safely
        final map = rawMap.map((k, v) => MapEntry(k.toString(), v));
        tickets.add(Ticket.fromJson(map));
      }
      // Sort descending by date
      tickets.sort((a, b) => b.date.compareTo(a.date));
      return tickets;
    } catch (e) {
      debugPrint('Error reading offline tickets: $e');
      return [];
    }
  }

  static Future<Ticket?> getTicketById(String id) async {
    final box = await Hive.openBox(_offlineBox);

    if (await _hasNetwork()) {
      try {
        final response = await _supabase
            .from('tickets')
            .select(
              '*, Booking!inner(*, TripSchedule(*, Trip:trips(*, busAgent:bus_agents(*), Route(*, departureCity:cities!Route_departureCityId_fkey(name), arrivalCity:cities!Route_arrivalCityId_fkey(name))))), Passenger(*)',
            )
            .eq('id', id)
            .maybeSingle();

        if (response == null) return null;
        final ticket = Ticket.fromJson(response);
        // Update cache for this specific ticket
        await box.put(ticket.id, ticket.toJson());
        return ticket;
      } catch (e) {
        debugPrint('Error fetching ticket by ID online: $e');
        return _getOfflineTicketById(box, id);
      }
    } else {
      return _getOfflineTicketById(box, id);
    }
  }

  static Ticket? _getOfflineTicketById(Box box, String id) {
    try {
      final rawMap = box.get(id);
      if (rawMap == null) return null;
      final map = (rawMap as Map<dynamic, dynamic>).map(
        (k, v) => MapEntry(k.toString(), v),
      );
      return Ticket.fromJson(map);
    } catch (e) {
      debugPrint('Error reading offline ticket by ID: $e');
      return null;
    }
  }
}
