// ignore_for_file: avoid_print`nimport 'dart:io';
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`nvoid main() {
// ignore_for_file: avoid_print`n  final dirs = [
// ignore_for_file: avoid_print`n    'lib/screens/auth',
// ignore_for_file: avoid_print`n    'lib/screens/onboarding',
// ignore_for_file: avoid_print`n    'lib/features/booking/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/payment/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/profile/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/settings/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/ticket/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/ai_chat/presentation/screens',
// ignore_for_file: avoid_print`n    'lib/features/notification/presentation/screens',
// ignore_for_file: avoid_print`n  ];
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n  for (final dir in dirs) {
// ignore_for_file: avoid_print`n    final d = Directory(dir);
// ignore_for_file: avoid_print`n    if (!d.existsSync()) continue;
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n    for (final entity in d.listSync(recursive: true)) {
// ignore_for_file: avoid_print`n      if (entity is File && entity.path.endsWith('screen.dart')) {
// ignore_for_file: avoid_print`n        String content = entity.readAsStringSync();
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n        // Find the start of the build method
// ignore_for_file: avoid_print`n        final buildIdx = content.indexOf(
// ignore_for_file: avoid_print`n          'Widget build(BuildContext context) {',
// ignore_for_file: avoid_print`n        );
// ignore_for_file: avoid_print`n        if (buildIdx != -1) {
// ignore_for_file: avoid_print`n          int braceCount = 0;
// ignore_for_file: avoid_print`n          int startBody =
// ignore_for_file: avoid_print`n              buildIdx + 'Widget build(BuildContext context) {'.length;
// ignore_for_file: avoid_print`n          int endBody = -1;
// ignore_for_file: avoid_print`n          for (int i = startBody; i < content.length; i++) {
// ignore_for_file: avoid_print`n            if (content[i] == '{') braceCount++;
// ignore_for_file: avoid_print`n            if (content[i] == '}') {
// ignore_for_file: avoid_print`n              if (braceCount == 0) {
// ignore_for_file: avoid_print`n                endBody = i;
// ignore_for_file: avoid_print`n                break;
// ignore_for_file: avoid_print`n              }
// ignore_for_file: avoid_print`n              braceCount--;
// ignore_for_file: avoid_print`n            }
// ignore_for_file: avoid_print`n          }
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n          if (endBody != -1) {
// ignore_for_file: avoid_print`n            String className = entity.uri.pathSegments.last.replaceAll(
// ignore_for_file: avoid_print`n              '.dart',
// ignore_for_file: avoid_print`n              '',
// ignore_for_file: avoid_print`n            );
// ignore_for_file: avoid_print`n            String newBody =
// ignore_for_file: avoid_print`n                '\n    return const Scaffold(\n      body: Center(child: Text("UI Reset - $className")),\n    );\n  ';
// ignore_for_file: avoid_print`n            content =
// ignore_for_file: avoid_print`n                '${content.substring(0, startBody - 1)}{$newBody${content.substring(endBody + 1)}';
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n            // Add material import if missing
// ignore_for_file: avoid_print`n            if (!content.contains("import 'package:flutter/material.dart';")) {
// ignore_for_file: avoid_print`n              content = "import 'package:flutter/material.dart';\n$content";
// ignore_for_file: avoid_print`n            }
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n            entity.writeAsStringSync(content);
// ignore_for_file: avoid_print`n            print('Reset \${entity.path}');
// ignore_for_file: avoid_print`n          }
// ignore_for_file: avoid_print`n        }
// ignore_for_file: avoid_print`n      }
// ignore_for_file: avoid_print`n    }
// ignore_for_file: avoid_print`n  }
// ignore_for_file: avoid_print`n}
