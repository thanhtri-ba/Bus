import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:intl/intl.dart';
import 'package:busz/screens/home/widgets/date_picker_bottom_sheet.dart';

class HomeSearchCard extends StatefulWidget {
  final VoidCallback onSearch;
  final VoidCallback onSelectFrom;
  final VoidCallback onSelectTo;

  const HomeSearchCard({
    super.key,
    required this.onSearch,
    required this.onSelectFrom,
    required this.onSelectTo,
  });

  @override
  State<HomeSearchCard> createState() => _HomeSearchCardState();
}

class _HomeSearchCardState extends State<HomeSearchCard> {
  bool _isRoundTrip = false;
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          // Tabs
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isRoundTrip = false),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: _isRoundTrip
                            ? Colors.transparent
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isRoundTrip
                              ? Colors.transparent
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.arrow_right_alt_rounded,
                            size: 18,
                            color: _isRoundTrip
                                ? Colors.grey[500]
                                : Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'One-way trip',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: _isRoundTrip
                                  ? Colors.grey[500]
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isRoundTrip = true),
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      decoration: BoxDecoration(
                        color: !_isRoundTrip
                            ? Colors.transparent
                            : Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: !_isRoundTrip
                              ? Colors.transparent
                              : Colors.grey[300]!,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Symbols.swap_horiz_rounded,
                            size: 18,
                            color: !_isRoundTrip
                                ? Colors.grey[500]
                                : Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Round trip',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: !_isRoundTrip
                                  ? Colors.grey[500]
                                  : Colors.black87,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Inputs
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Stack(
              alignment: Alignment.centerRight,
              children: [
                Column(
                  children: [
                    GestureDetector(
                      onTap: widget.onSelectFrom,
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'From',
                          style: TextStyle(color: Colors.black38, fontSize: 16),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: widget.onSelectTo,
                      child: Container(
                        height: 56,
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey[300]!),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        alignment: Alignment.centerLeft,
                        child: const Text(
                          'To',
                          style: TextStyle(color: Colors.black38, fontSize: 16),
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 16,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    padding: const EdgeInsets.all(8),
                    child: const Icon(
                      Symbols.swap_vert_rounded,
                      color: Color(0xFF1A7F8E),
                      size: 20,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Date Selection
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () async {
                      final selected = await showModalBottomSheet<DateTime>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => const DatePickerBottomSheet(),
                      );
                      if (selected != null) {
                        setState(() => _selectedDate = selected);
                      }
                    },
                    child: Container(
                      height: 48,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Symbols.calendar_today_rounded,
                            size: 20,
                            color: Colors.black87,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            DateFormat('dd MMM').format(_selectedDate),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: const Color(0xFFE8F4F5),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Color(0xFF1A7F8E),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: Container(
                    height: 48,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: const Text(
                      'Tomorrow',
                      style: TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Search Button
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: ElevatedButton(
              onPressed: widget.onSearch,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1A7F8E),
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Search Bus',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
