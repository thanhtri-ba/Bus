import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:busz/services/bus_service.dart';
import 'package:busz/services/search_history_service.dart';
import 'package:busz/models/home_models.dart';

class SearchCityScreen extends StatefulWidget {
  final bool isDestination;

  const SearchCityScreen({super.key, required this.isDestination});

  @override
  State<SearchCityScreen> createState() => _SearchCityScreenState();
}

class _SearchCityScreenState extends State<SearchCityScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<SearchHistory> _history = [];
  List<Station> _popularDestinations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final history = await SearchHistoryService.getHistory();
    final destinations = await BusService.getPopularDestinations();
    setState(() {
      _history = history;
      _popularDestinations = destinations;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Symbols.close_rounded, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search by city or station',
            hintStyle: TextStyle(color: Colors.grey[400]),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 0,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: BorderSide(color: Colors.grey[200]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(24),
              borderSide: const BorderSide(color: Color(0xFF1A7F8E)),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location
            ListTile(
              leading: const Icon(
                Symbols.my_location_rounded,
                color: Color(0xFF1A7F8E),
              ),
              title: const Text(
                'Use current location',
                style: TextStyle(
                  color: Color(0xFF1A7F8E),
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: const Text(
                'Senayan, Center Jakarta',
                style: TextStyle(color: Colors.black45),
              ),
              onTap: () {
                Navigator.pop(context, 'Senayan');
              },
            ),

            Divider(color: Colors.grey[100], thickness: 8),

            // Search History
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Search history',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: const Text(
                      'Delete',
                      style: TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ..._history
                .take(2)
                .map(
                  (h) => Column(
                    children: [
                      _buildHistoryItem(h.route),
                      const Divider(height: 1),
                    ],
                  ),
                ),

            Divider(color: Colors.grey[100], thickness: 8),

            // Popular destinations
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Popular destination',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Wrap(
                spacing: 8,
                runSpacing: 8,
                children: _popularDestinations
                    .map((d) => _buildPopularChip(d.name))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryItem(String text) {
    return ListTile(
      title: Text(text, style: const TextStyle(color: Colors.black54)),
      onTap: () {
        Navigator.pop(context, text.split(' - ').last);
      },
    );
  }

  Widget _buildPopularChip(String text) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context, text);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 13,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}
