import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:busz/models/home_models.dart';

class BusService {
  static final _supabase = Supabase.instance.client;
  static final _cache = Hive.box('offline_cache');

  static Future<bool> _hasNetwork() async {
    final results = await Connectivity().checkConnectivity();
    return results.any((r) => r != ConnectivityResult.none);
  }

  static Future<List<City>> searchCities(String query) async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) throw Exception('No network');

      final response = await _supabase
          .from('cities')
          .select()
          .ilike('name', '%$query%')
          .order('name')
          .limit(20);

      if (query.isEmpty) _cache.put('cities', response);
      return response.map((e) => City.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error searching cities: $e');
      if (query.isEmpty) {
        final cached = _cache.get('cities');
        if (cached != null) {
          return (cached as List)
              .map((e) => City.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }
      }
      return [];
    }
  }

  static Future<List<Station>> getPopularDestinations() async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) throw Exception('No network');

      final response = await _supabase
          .from('stations')
          .select()
          .eq('is_popular', true)
          .order('name')
          .limit(10);

      _cache.put('popular_stations', response);
      return response.map((e) => Station.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting popular destinations: $e');
      final cached = _cache.get('popular_stations');
      if (cached != null) {
        return (cached as List)
            .map((e) => Station.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    }
  }

  static Future<List<City>> getPopularCities() async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) throw Exception('No network');

      final response = await _supabase
          .from('cities')
          .select('id, name, isPopular, image, subtitle')
          .eq('isPopular', true)
          .limit(10);

      _cache.put('popular_cities', response);
      return response.map((e) => City.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting popular cities: $e');
      final cached = _cache.get('popular_cities');
      if (cached != null) {
        return (cached as List)
            .map((e) => City.fromJson(Map<String, dynamic>.from(e)))
            .toList();
      }
      return [];
    }
  }

  static Future<List<Map<String, dynamic>>> getPopularRoutes() async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) throw Exception('No network');

      final routeResponse = await _supabase
          .from('Route')
          .select(
            'id, color, basePrice, durationMins, departureCityId, arrivalCityId',
          )
          .eq('isPopular', true)
          .limit(10);

      final cityResponse = await _supabase.from('cities').select('id, name');
      final cityMap = {for (var c in cityResponse) c['id']: c['name']};

      final results = (routeResponse as List).map((r) {
        final map = Map<String, dynamic>.from(r);
        map['departureCity'] = cityMap[r['departureCityId']] ?? '';
        map['arrivalCity'] = cityMap[r['arrivalCityId']] ?? '';
        return map;
      }).toList();

      _cache.put('popular_routes', results);
      return results;
    } catch (e) {
      debugPrint('Error getting popular routes: $e');
      final cached = _cache.get('popular_routes');
      if (cached != null) {
        return List<Map<String, dynamic>>.from(cached);
      }
      return [];
    }
  }

  static Future<List<Station>> searchStations(String query) async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) throw Exception('No network');

      final response = await _supabase
          .from('stations')
          .select()
          .ilike('name', '%$query%')
          .order('name')
          .limit(20);

      if (query.isEmpty) _cache.put('stations', response);
      return response.map((e) => Station.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error searching stations: $e');
      if (query.isEmpty) {
        final cached = _cache.get('stations');
        if (cached != null) {
          return (cached as List)
              .map((e) => Station.fromJson(Map<String, dynamic>.from(e)))
              .toList();
        }
      }
      return [];
    }
  }

  static const String _baseUrl = 'http://127.0.0.1:3000/api';

  static Future<List<Trip>> searchBuses(SearchRequest req) async {
    try {
      final isOnline = await _hasNetwork();
      if (!isOnline) {
        debugPrint('No network for searching buses.');
        return [];
      }

      final reqDep = req.departureCity;
      final reqArr = req.arrivalCity;

      final response = await http.get(Uri.parse('$_baseUrl/trips'));
      if (response.statusCode != 200) {
        throw Exception('Failed to load trips');
      }

      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'] ?? [];

      final filteredResponse = data.where((e) {
        final trip = e['Trip'] ?? e['trip'] ?? {};
        final route = trip['Route'] ?? trip['route'] ?? {};

        final depCityName = (route['departureCity']?['name'] as String? ?? '')
            .toLowerCase();
        final arrCityName = (route['arrivalCity']?['name'] as String? ?? '')
            .toLowerCase();

        final reqDepLower = reqDep.toLowerCase();
        final reqArrLower = reqArr.toLowerCase();

        final matchDep = depCityName.contains(reqDepLower);
        final matchArr = arrCityName.contains(reqArrLower);

        return matchDep && matchArr;
      }).toList();

      return filteredResponse.map((e) => Trip.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error searching buses: $e');
      return [];
    }
  }

  static Future<List<CalendarPrice>> getCalendarPrices(
    int year,
    int month,
  ) async {
    // Keep mock for calendar prices as it requires complex logic
    await Future.delayed(const Duration(milliseconds: 200));
    int daysInMonth = DateTime(year, month + 1, 0).day;
    List<CalendarPrice> prices = [];

    for (int day = 1; day <= daysInMonth; day++) {
      String priceStr = '320k ₫';
      Color priceColor = Colors.black54;

      if (day % 4 == 0) {
        priceStr = '400k ₫';
        priceColor = Colors.red[400]!;
      } else if (day % 7 == 0) {
        priceStr = '250k ₫';
        priceColor = const Color(0xFF13B57B);
      }

      prices.add(
        CalendarPrice(
          date: DateTime(year, month, day),
          priceStr: priceStr,
          priceColor: priceColor,
        ),
      );
    }

    return prices;
  }

  static Future<List<BusAgent>> getBusAgents() async {
    try {
      final response = await _supabase
          .from('bus_agents')
          .select()
          .order('name');
      return response.map((e) => BusAgent.fromJson(e)).toList();
    } catch (e) {
      debugPrint('Error getting bus agents: $e');
      return [];
    }
  }
}
