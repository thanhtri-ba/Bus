import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:busz/features/auth/presentation/screens/select_verification_screen.dart';

void main() {
  Widget createTestWidget() {
    return const MaterialApp(
      home: SelectVerificationScreen(phone: '626282198761234'),
    );
  }

  group('SelectVerificationScreen Widget Tests', () {
    testWidgets('1. Render UI components correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Verification Method'), findsOneWidget);
      expect(
        find.text('Select verification method below to continue.'),
        findsOneWidget,
      );
      expect(find.text('Send message to'), findsOneWidget);
      expect(find.text('WhatsApp to'), findsOneWidget);
      expect(
        find.text('626282198761234'),
        findsNWidgets(2),
      ); // Both SMS and WA buttons show phone
    });
  });
}
