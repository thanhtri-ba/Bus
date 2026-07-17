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
// ignore_for_file: avoid_print`n        // Find the signature of our reset body
// ignore_for_file: avoid_print`n        if (content.contains('return const Scaffold(') &&
// ignore_for_file: avoid_print`n            content.contains('UI Reset - ')) {
// ignore_for_file: avoid_print`n          // We need to append a '}' before the final '}' of the class
// ignore_for_file: avoid_print`n          // Wait, a simpler way is to just find the text:
// ignore_for_file: avoid_print`n          // '    );\n  \n}' -> meaning it ends without the build method brace.
// ignore_for_file: avoid_print`n          // Actually, let's just append '}' at the end of newBody where it's missing.
// ignore_for_file: avoid_print`n          // Since we replaced it, the file ends with a single '}' (the class brace).
// ignore_for_file: avoid_print`n          // It should end with TWO '}' (one for build, one for class).
// ignore_for_file: avoid_print`n          // Let's just fix the files that have syntax errors.
// ignore_for_file: avoid_print`n          // It's easier to just find:
// ignore_for_file: avoid_print`n          /*
// ignore_for_file: avoid_print`n    return const Scaffold(
// ignore_for_file: avoid_print`n      body: Center(child: Text("UI Reset - xxx")),
// ignore_for_file: avoid_print`n    );
// ignore_for_file: avoid_print`n  
// ignore_for_file: avoid_print`n}
// ignore_for_file: avoid_print`n           */
// ignore_for_file: avoid_print`n          // and replace it with:
// ignore_for_file: avoid_print`n          /*
// ignore_for_file: avoid_print`n    return const Scaffold(
// ignore_for_file: avoid_print`n      body: Center(child: Text("UI Reset - xxx")),
// ignore_for_file: avoid_print`n    );
// ignore_for_file: avoid_print`n  }
// ignore_for_file: avoid_print`n}
// ignore_for_file: avoid_print`n           */
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n          content = content.replaceAll(');\n  \n}', ');\n  }\n}');
// ignore_for_file: avoid_print`n          // Just in case it has different trailing spaces:
// ignore_for_file: avoid_print`n          content = content.replaceAll(');\n  \n\n}', ');\n  }\n}');
// ignore_for_file: avoid_print`n
// ignore_for_file: avoid_print`n          entity.writeAsStringSync(content);
// ignore_for_file: avoid_print`n          print('Fixed \${entity.path}');
// ignore_for_file: avoid_print`n        }
// ignore_for_file: avoid_print`n      }
// ignore_for_file: avoid_print`n    }
// ignore_for_file: avoid_print`n  }
// ignore_for_file: avoid_print`n}
