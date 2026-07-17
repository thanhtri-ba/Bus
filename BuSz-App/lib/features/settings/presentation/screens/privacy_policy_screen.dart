import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_spacing.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chính sách bảo mật'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Chính sách bảo mật dữ liệu',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '1. Thu thập thông tin\n'
              'Chúng tôi thu thập thông tin của bạn khi bạn đăng ký tài khoản, đặt vé và sử dụng dịch vụ trên ứng dụng BusZ. Các thông tin này bao gồm Tên, Số điện thoại, Email và vị trí.\n\n'
              '2. Sử dụng thông tin\n'
              'Thông tin của bạn được sử dụng để xác nhận đặt vé, gửi mã QR, thông báo lịch trình và cải thiện trải nghiệm người dùng.\n\n'
              '3. Chia sẻ thông tin\n'
              'BusZ cam kết không bán hoặc chia sẻ thông tin cá nhân của bạn cho bên thứ ba vì mục đích thương mại. Chúng tôi chỉ cung cấp thông tin cho nhà xe để đối chiếu khi bạn lên xe.\n\n'
              '4. Bảo mật dữ liệu\n'
              'Toàn bộ giao dịch và dữ liệu cá nhân của bạn đều được mã hóa bằng tiêu chuẩn SSL/TLS và lưu trữ an toàn trên nền tảng Supabase.\n\n'
              '5. Quyền lợi người dùng\n'
              'Bạn có quyền yêu cầu xóa toàn bộ dữ liệu cá nhân của mình khỏi hệ thống BusZ bất cứ lúc nào thông qua phần Cài đặt tài khoản.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.6,
                color: Theme.of(
                  context,
                ).colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
