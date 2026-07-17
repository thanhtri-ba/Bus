// ignore_for_file: avoid_print`nimport 'dart:io';
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`nvoid main() {
// ignore_for_file: avoid_print`n  final dirs = [
// ignore_for_file: avoid_print`n    'lib/features/booking/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/payment/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/profile/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/settings/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/ticket/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/ai_chat/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/notification/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/main_shell',
// ignore_for_file: avoid_print`n  ];
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n  for (final dir in dirs) {
// ignore_for_file: avoid_print`n    final d = Directory(dir);
// ignore_for_file: avoid_print`n    if (!d.existsSync()) continue;
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n    for (final entity in d.listSync(recursive: true)) {
// ignore_for_file: avoid_print`n      if (entity is File && entity.path.endsWith('screen.dart')) {
// ignore_for_file: avoid_print`n        String content = entity.readAsStringSync();
// ignore_for_file: avoid_print`n        final match = RegExp(
// ignore_for_file: avoid_print`n          r'class\s+([a-zA-Z0-9_]+)\s+extends\s+(StatefulWidget|StatelessWidget)',
// ignore_for_file: avoid_print`n        ).firstMatch(content);
// ignore_for_file: avoid_print`n        if (match != null) {
// ignore_for_file: avoid_print`n          String className = match.group(1)!;
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n          String args = '';
// ignore_for_file: avoid_print`n          String fields = '';
// ignore_for_file: avoid_print`n          if (className == 'TripDetailScreen' ||
// ignore_for_file: avoid_print`n              className == 'SeatSelectionScreen') {
// ignore_for_file: avoid_print`n            args = 'required this.tripId, ';
// ignore_for_file: avoid_print`n            fields = 'final String tripId;';
// ignore_for_file: avoid_print`n          } else if (className == 'PaymentResultScreen') {
// ignore_for_file: avoid_print`n            args = 'required this.isSuccess, ';
// ignore_for_file: avoid_print`n            fields = 'final bool isSuccess;';
// ignore_for_file: avoid_print`n          } else if (className == 'TicketDetailScreen') {
// ignore_for_file: avoid_print`n            args = 'required this.ticketId, ';
// ignore_for_file: avoid_print`n            fields = 'final String ticketId;';
// ignore_for_file: avoid_print`n          } else if (className == 'MainShellScreen') {
// ignore_for_file: avoid_print`n            args = 'required this.child, ';
// ignore_for_file: avoid_print`n            fields = 'final Widget child;';
// ignore_for_file: avoid_print`n          }
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n          String newContent =
// ignore_for_file: avoid_print`n              '''
// ignore_for_file: avoid_print`nimport 'package:flutter/material.dart';
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`nclass $className extends StatelessWidget {
// ignore_for_file: avoid_print`n  $fields
// ignore_for_file: avoid_print`n  
// ignore_for_file: avoid_print`n  const $className({super.key, $args});
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n  @override
// ignore_for_file: avoid_print`n  Widget build(BuildContext context) {
// ignore_for_file: avoid_print`n    ${className == 'MainShellScreen' ? 'return child;' : 'return const Scaffold(body: Center(child: Text("UI Reset - $className")),);'}
// ignore_for_file: avoid_print`n  }
// ignore_for_file: avoid_print`n}
// ignore_for_file: avoid_print`n''';
// ignore_for_file: avoid_print`n          entity.writeAsStringSync(newContent);
// ignore_for_file: avoid_print`n          print('Reset \${entity.path}');
// ignore_for_file: avoid_print`n        }
// ignore_for_file: avoid_print`n      }
// ignore_for_file: avoid_print`n    }
// ignore_for_file: avoid_print`n  }
// ignore_for_file: avoid_print`n}
