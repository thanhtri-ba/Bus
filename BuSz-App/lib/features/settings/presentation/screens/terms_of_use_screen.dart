import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_spacing.dart';

class TermsOfUseScreen extends StatelessWidget {
  const TermsOfUseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Điều khoản sử dụng'),
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
              'Điều khoản & Điều kiện',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              '1. Chấp nhận điều khoản\n'
              'Bằng việc tải xuống và sử dụng ứng dụng BusZ, bạn đồng ý tuân thủ các Điều khoản sử dụng này.\n\n'
              '2. Dịch vụ đặt vé\n'
              'BusZ đóng vai trò là nền tảng trung gian kết nối hành khách với các nhà xe. Chúng tôi không trực tiếp vận hành các chuyến xe. Mọi vấn đề phát sinh trong quá trình di chuyển sẽ do nhà xe chịu trách nhiệm giải quyết dựa trên chính sách của họ.\n\n'
              '3. Thanh toán & Hoàn tiền\n'
              'Người dùng có nghĩa vụ thanh toán đầy đủ khi đặt vé. Chính sách hoàn hủy (refund) phụ thuộc vào từng nhà xe và hạng vé. BusZ sẽ hỗ trợ quy trình hoàn tiền nếu yêu cầu của bạn hợp lệ theo chính sách đã công bố lúc mua.\n\n'
              '4. Hành vi cấm\n'
              'Tuyệt đối nghiêm cấm các hành vi sử dụng phần mềm thứ ba để can thiệp, thay đổi giá vé, hoặc trục lợi từ hệ thống khuyến mãi của BusZ.\n\n'
              '5. Thay đổi điều khoản\n'
              'Chúng tôi có quyền cập nhật các Điều khoản này bất kỳ lúc nào. Việc bạn tiếp tục sử dụng ứng dụng sau khi có thay đổi đồng nghĩa với việc bạn chấp nhận các điều khoản mới.',
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
