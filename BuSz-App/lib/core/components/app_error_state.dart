import 'package:flutter/material.dart';
import 'package:busz/core/components/app_empty_state.dart';

class AppErrorState extends StatelessWidget {
  final String? title;
  final String? message;
  final VoidCallback? onRetry;

  const AppErrorState({super.key, this.title, this.message, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return AppEmptyState(
      icon: Icons.error_outline,
      title: title ?? 'Đã có lỗi xảy ra',
      description: message ?? 'Vui lòng kiểm tra kết nối mạng và thử lại sau.',
      buttonText: onRetry != null ? 'Thử lại' : null,
      onButtonTap: onRetry,
    );
  }
}
