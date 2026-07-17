import 'package:flutter_riverpod/flutter_riverpod.dart';

enum PaymentStatus { initial, processing, success, failed }

class PaymentState {
  final PaymentStatus status;
  final String? errorMessage;
  final String selectedMethod;

  const PaymentState({
    this.status = PaymentStatus.initial,
    this.errorMessage,
    this.selectedMethod = 'momo',
  });

  PaymentState copyWith({
    PaymentStatus? status,
    String? errorMessage,
    String? selectedMethod,
  }) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage, // nullable
      selectedMethod: selectedMethod ?? this.selectedMethod,
    );
  }
}

class PaymentNotifier extends Notifier<PaymentState> {
  @override
  PaymentState build() {
    return const PaymentState();
  }

  void selectMethod(String method) {
    state = state.copyWith(selectedMethod: method);
  }

  Future<void> processPayment() async {
    state = state.copyWith(status: PaymentStatus.processing);

    // Simulate network delay and 3rd-party payment gateway integration
    await Future.delayed(const Duration(seconds: 2));

    // Simulate an 80% success rate for demonstration
    final isSuccess = DateTime.now().millisecondsSinceEpoch % 10 < 8;

    if (isSuccess) {
      state = state.copyWith(status: PaymentStatus.success);
    } else {
      state = state.copyWith(
        status: PaymentStatus.failed,
        errorMessage: 'Số dư không đủ hoặc kết nối bị gián đoạn.',
      );
    }
  }

  void reset() {
    state = const PaymentState();
  }
}

final paymentStateProvider = NotifierProvider<PaymentNotifier, PaymentState>(
  () {
    return PaymentNotifier();
  },
);
