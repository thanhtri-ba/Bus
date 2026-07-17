import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:busz/features/auth/presentation/screens/otp_screen.dart';

void main() {
  Widget createTestWidget() {
    return const ProviderScope(
      child: MaterialApp(home: OtpScreen(phone: '626282198761234')),
    );
  }

  group('OtpScreen Widget Tests', () {
    testWidgets('1. Render UI components correctly', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      expect(find.text('Input Verification Code'), findsOneWidget);
      expect(
        find.text('We have sent code to your phone number\n626282198761234'),
        findsOneWidget,
      );
      expect(find.byType(Pinput), findsOneWidget);
      expect(
        find.text("Didn't receive code? Resend", findRichText: true),
        findsOneWidget,
      );
    });

    testWidgets('2. Failed OTP state for number 2457', (
      WidgetTester tester,
    ) async {
      await tester.pumpWidget(createTestWidget());
      await tester.pumpAndSettle();

      // Enter the failed OTP code
      await tester.enterText(find.byType(Pinput), '2457');
      await tester.pumpAndSettle();

      // Wait for fake delay
      await tester.pump(const Duration(milliseconds: 1500));
      await tester.pumpAndSettle();

      expect(find.text('Verification code incorrect'), findsOneWidget);
    });
  });
}
