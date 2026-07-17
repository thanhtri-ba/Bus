import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';

import 'package:busz/services/bus_service.dart';
import 'package:busz/models/home_models.dart';

class DatePickerBottomSheet extends StatefulWidget {
  const DatePickerBottomSheet({super.key});

  @override
  State<DatePickerBottomSheet> createState() => _DatePickerBottomSheetState();
}

class _DatePickerBottomSheetState extends State<DatePickerBottomSheet> {
  DateTime? _selectedDate;
  Map<DateTime, CalendarPrice> _prices = {};

  @override
  void initState() {
    super.initState();
    _loadPrices();
  }

  Future<void> _loadPrices() async {
    final pricesJan = await BusService.getCalendarPrices(2025, 1);
    final pricesFeb = await BusService.getCalendarPrices(2025, 2);

    final Map<DateTime, CalendarPrice> map = {};
    for (var p in [...pricesJan, ...pricesFeb]) {
      map[p.date] = p;
    }
    setState(() {
      _prices = map;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        children: [
          // Header
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Symbols.close_rounded,
                    color: Colors.black87,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
                const Expanded(
                  child: Center(
                    child: Text(
                      'Select Dates',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 48), // Balance for back button
              ],
            ),
          ),

          // Days of Week
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildDayOfWeek('Mon'),
                _buildDayOfWeek('Tue'),
                _buildDayOfWeek('Wed'),
                _buildDayOfWeek('Thu'),
                _buildDayOfWeek('Fri'),
                _buildDayOfWeek('Sat', isWeekend: true),
                _buildDayOfWeek('Sun', isWeekend: true),
              ],
            ),
          ),

          const Divider(height: 1),

          // Calendar Grid
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 16.0,
              ),
              children: [
                _buildMonthView(
                  'January 2025',
                  2025,
                  1,
                  3,
                ), // Starts on Wednesday
                const SizedBox(height: 32),
                _buildMonthView(
                  'February 2025',
                  2025,
                  2,
                  6,
                ), // Starts on Saturday
              ],
            ),
          ),

          // Bottom selection action
          if (_selectedDate != null)
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Departure Date',
                    style: TextStyle(color: Colors.black54, fontSize: 12),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('EEE, MMM d').format(_selectedDate!),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, _selectedDate);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A7F8E),
                      minimumSize: const Size(double.infinity, 48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Select Date',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDayOfWeek(String text, {bool isWeekend = false}) {
    return Text(
      text,
      style: TextStyle(
        color: isWeekend ? const Color(0xFF1A7F8E) : Colors.black54,
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }

  Widget _buildMonthView(
    String title,
    int year,
    int month,
    int startingWeekdayOffset,
  ) {
    int daysInMonth = DateTime(year, month + 1, 0).day;
    int totalCells = daysInMonth + startingWeekdayOffset;

    return Column(
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 7,
            childAspectRatio: 0.8,
            crossAxisSpacing: 4,
            mainAxisSpacing: 8,
          ),
          itemCount: totalCells,
          itemBuilder: (context, index) {
            if (index < startingWeekdayOffset) return const SizedBox();

            int day = index - startingWeekdayOffset + 1;
            DateTime date = DateTime(year, month, day);
            bool isSelected =
                _selectedDate != null &&
                _selectedDate!.year == year &&
                _selectedDate!.month == month &&
                _selectedDate!.day == day;

            CalendarPrice? cp = _prices[date];
            String price = cp?.priceStr ?? '';
            Color priceColor = cp?.priceColor ?? Colors.transparent;

            return GestureDetector(
              onTap: () {
                setState(() {
                  _selectedDate = date;
                });
              },
              child: Container(
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF1A7F8E)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$day',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: isSelected ? Colors.white : Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      price,
                      style: TextStyle(
                        fontSize: 8,
                        color: isSelected ? Colors.white70 : priceColor,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
