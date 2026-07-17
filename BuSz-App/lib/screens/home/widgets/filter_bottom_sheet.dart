import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';

import 'package:busz/services/bus_service.dart';
import 'package:busz/models/home_models.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({super.key});

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  final List<String> _deptTimes = [
    '00:00 - 06:00',
    '06:00 - 12:00',
    '12:00 - 18:00',
    '18:00 - 00:00',
  ];
  final List<String> _arrTimes = [
    '00:00 - 06:00',
    '06:00 - 12:00',
    '12:00 - 18:00',
    '18:00 - 00:00',
  ];
  List<BusAgent> _agents = [];

  String? _selectedDeptTime;
  String? _selectedArrTime;
  final List<String> _selectedAgents = [];

  @override
  void initState() {
    super.initState();
    _loadAgents();
  }

  Future<void> _loadAgents() async {
    final agents = await BusService.getBusAgents();
    setState(() {
      _agents = agents;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(
                      Symbols.close_rounded,
                      color: Colors.black87,
                    ),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Text(
                    'Filter',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 48), // balance
                ],
              ),
            ),

            Flexible(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Departure Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      children: _deptTimes
                          .map(
                            (e) => _buildTimeChip(e, _selectedDeptTime == e, (
                              val,
                            ) {
                              setState(() => _selectedDeptTime = e);
                            }),
                          )
                          .toList(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(height: 1),
                    ),

                    const Text(
                      'Arrival Time',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 8,
                      runSpacing: 12,
                      children: _arrTimes
                          .map(
                            (e) =>
                                _buildTimeChip(e, _selectedArrTime == e, (val) {
                                  setState(() => _selectedArrTime = e);
                                }),
                          )
                          .toList(),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24),
                      child: Divider(height: 1),
                    ),

                    const Text(
                      'Bus Agent',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ..._agents.map((e) => _buildAgentCheckbox(e.name)),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _selectedDeptTime = null;
                        _selectedArrTime = null;
                        _selectedAgents.clear();
                      });
                    },
                    child: const Text(
                      'Reset Filter',
                      style: TextStyle(
                        color: Colors.black87,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A7F8E),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Search Bus',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeChip(
    String text,
    bool isSelected,
    Function(bool) onSelected,
  ) {
    return ChoiceChip(
      label: Text(text),
      selected: isSelected,
      onSelected: onSelected,
      backgroundColor: Colors.white,
      selectedColor: const Color(0xFF1A7F8E).withValues(alpha: 0.1),
      labelStyle: TextStyle(
        color: isSelected ? const Color(0xFF1A7F8E) : Colors.black54,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected ? const Color(0xFF1A7F8E) : Colors.grey[300]!,
        ),
      ),
    );
  }

  Widget _buildAgentCheckbox(String agent) {
    return CheckboxListTile(
      title: Text(agent, style: const TextStyle(fontSize: 15)),
      value: _selectedAgents.contains(agent),
      onChanged: (val) {
        setState(() {
          if (val == true) {
            _selectedAgents.add(agent);
          } else {
            _selectedAgents.remove(agent);
          }
        });
      },
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.trailing,
      activeColor: const Color(0xFF1A7F8E),
      checkboxShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
