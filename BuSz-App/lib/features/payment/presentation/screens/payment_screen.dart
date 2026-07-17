import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/router/route_names.dart';
import 'package:busz/providers/booking_provider.dart';
import 'package:busz/core/di/injection.dart';
import 'package:busz/services/payment_method_service.dart';
import 'package:busz/services/booking_service.dart';
import 'package:busz/features/payment/presentation/widgets/card_scanner_dialog.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedMethod = 0;
  bool _agreedTerms = false;
  bool _agreedPrivacy = false;
  bool _isProcessing = false;

  final PaymentMethodService _paymentMethodService = sl<PaymentMethodService>();
  List<_PaymentMethod> _savedMethods = [];
  bool _isLoadingMethods = true;

  final _defaultMethods = const [
    _PaymentMethod(
      name: 'VNPay',
      icon: Symbols.account_balance_rounded,
      description: 'Thanh toán qua VNPay',
    ),
    _PaymentMethod(
      name: 'MoMo',
      icon: Symbols.phone_android_rounded,
      description: 'Ví điện tử MoMo',
    ),
    _PaymentMethod(
      name: 'ZaloPay',
      icon: Symbols.wallet_rounded,
      description: 'Ví điện tử ZaloPay',
    ),
    _PaymentMethod(
      name: 'Thẻ tín dụng',
      icon: Symbols.credit_card_rounded,
      description: 'Visa, Mastercard, JCB',
    ),
    _PaymentMethod(
      name: 'Thẻ ghi nợ',
      icon: Symbols.credit_card_rounded,
      description: 'ATM nội địa',
    ),
    _PaymentMethod(
      name: 'Thanh toán tại quầy',
      icon: Symbols.store_rounded,
      description: 'Trả tiền mặt tại quầy',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _loadSavedMethods();
  }

  Future<void> _loadSavedMethods() async {
    try {
      final methods = await _paymentMethodService.getPaymentMethods();
      if (mounted) {
        setState(() {
          _savedMethods = methods.map((m) {
            IconData icon = Symbols.credit_card_rounded;
            if (m.type == 'MoMo' || m.type == 'ZaloPay') {
              icon = Symbols.account_balance_wallet_rounded;
            }
            return _PaymentMethod(
              name: m.type == 'Visa' ? 'Thẻ tín dụng (Visa)' : 'Ví ${m.type}',
              icon: icon,
              description: m.info,
              isSaved: true,
            );
          }).toList();
          _isLoadingMethods = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingMethods = false);
      }
    }
  }

  bool get _canPay => _agreedTerms && _agreedPrivacy;

  List<_PaymentMethod> get _allMethods => [
    ..._savedMethods,
    ..._defaultMethods,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thanh toán'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Countdown
            Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.warningLight,
                borderRadius: AppRadius.smallAll,
              ),
              child: Row(
                children: [
                  const Icon(
                    Symbols.timer_rounded,
                    size: 20,
                    color: AppColors.warning,
                  ),
                  const SizedBox(width: AppSpacing.xs),
                  Text(
                    'Hoàn tất thanh toán trong ',
                    style: AppTextStyles.bodySmall,
                  ),
                  Text(
                    '14:59',
                    style: AppTextStyles.label.copyWith(
                      color: AppColors.warning,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Payment Methods
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Phương thức thanh toán', style: AppTextStyles.titleSmall),
                TextButton(
                  onPressed: () => context
                      .push(RouteNames.paymentMethods)
                      .then((_) => _loadSavedMethods()),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.zero,
                    minimumSize: const Size(0, 0),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  child: Text(
                    'Quản lý',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),

            if (_isLoadingMethods)
              const Center(child: CircularProgressIndicator())
            else
              ...List.generate(_allMethods.length, (i) {
                final m = _allMethods[i];
                final isSelected = _selectedMethod == i;
                return GestureDetector(
                  onTap: () => setState(() => _selectedMethod = i),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: AppSpacing.xs),
                    padding: const EdgeInsets.all(AppSpacing.md),
                    decoration: BoxDecoration(
                      color: AppColors.surfaceCard,
                      borderRadius: AppRadius.mediumAll,
                      border: Border.all(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.borderLight,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppColors.primaryLight
                                : AppColors.gray100,
                            borderRadius: AppRadius.smallAll,
                          ),
                          child: Icon(
                            m.icon,
                            color: isSelected
                                ? AppColors.primary
                                : AppColors.gray500,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(m.name, style: AppTextStyles.label),
                                  if (m.isSaved) ...[
                                    const SizedBox(width: AppSpacing.xs),
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 2,
                                      ),
                                      decoration: BoxDecoration(
                                        color: AppColors.success.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: AppRadius.pillAll,
                                      ),
                                      child: Text(
                                        'Đã lưu',
                                        style: AppTextStyles.captionSmall
                                            .copyWith(color: AppColors.success),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                              Text(m.description, style: AppTextStyles.caption),
                              if (m.name.contains('Thẻ tín dụng')) ...[
                                const SizedBox(height: AppSpacing.sm),
                                if (isSelected)
                                  ElevatedButton.icon(
                                    onPressed: () async {
                                      final result = await showDialog(
                                        context: context,
                                        builder: (ctx) =>
                                            const CardScannerDialog(),
                                      );
                                      if (result != null) {
                                        if (!context.mounted) return;
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Đã thêm thẻ ${result['cardNumber']}',
                                            ),
                                          ),
                                        );
                                      }
                                    },
                                    icon: const Icon(
                                      Symbols.photo_camera_rounded,
                                      size: 18,
                                    ),
                                    label: const Text('Quét Thẻ Nhanh'),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppColors.primaryLight,
                                      foregroundColor: AppColors.primary,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 8,
                                      ),
                                      minimumSize: Size.zero,
                                    ),
                                  ),
                              ],
                            ],
                          ),
                        ),
                        Radio<int>(
                          value: i,
                          // ignore: deprecated_member_use
                          groupValue: _selectedMethod,
                          // ignore: deprecated_member_use
                          onChanged: (v) =>
                              setState(() => _selectedMethod = v!),
                          activeColor: AppColors.primary,
                        ),
                      ],
                    ),
                  ),
                );
              }),

            const SizedBox(height: AppSpacing.lg),

            // Price Breakdown
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surfaceCard,
                borderRadius: AppRadius.card,
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chi tiết thanh toán', style: AppTextStyles.titleSmall),
                  const SizedBox(height: AppSpacing.sm),
                  _buildPriceRow('Giá vé', '700.000đ'),
                  _buildPriceRow('Giảm giá', '-50.000đ'),
                  _buildPriceRow('Phí dịch vụ', '10.000đ'),
                  _buildPriceRow('VAT (10%)', '65.000đ'),
                  const Divider(height: AppSpacing.xl),
                  _buildPriceRow('Tổng cộng', '725.000đ', isTotal: true),
                ],
              ),
            ),

            const SizedBox(height: AppSpacing.lg),

            // Agreement
            CheckboxListTile(
              value: _agreedTerms,
              onChanged: (v) => setState(() => _agreedTerms = v!),
              title: Text(
                'Tôi đồng ý với Điều khoản & Điều kiện',
                style: AppTextStyles.bodySmall,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.primary,
              dense: true,
            ),
            CheckboxListTile(
              value: _agreedPrivacy,
              onChanged: (v) => setState(() => _agreedPrivacy = v!),
              title: Text(
                'Tôi đồng ý với Chính sách Bảo mật',
                style: AppTextStyles.bodySmall,
              ),
              controlAffinity: ListTileControlAffinity.leading,
              contentPadding: EdgeInsets.zero,
              activeColor: AppColors.primary,
              dense: true,
            ),

            const SizedBox(height: 80),
          ],
        ),
      ),

      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surfacePrimary,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: SafeArea(
          child: Consumer<BookingProvider>(
            builder: (context, booking, _) => ElevatedButton(
              onPressed: _canPay && !_isProcessing
                  ? () async {
                      setState(() => _isProcessing = true);
                      final success =
                          await BookingService.createBookingAndTicket(
                            tripScheduleId: booking.selectedTrip?.id ?? '',
                            seatNumbers: booking.selectedSeats,
                            passengers: booking.passengers.isNotEmpty
                                ? booking.passengers
                                : [
                                    PassengerData(
                                      name: 'Khách hàng',
                                      phone: '0123456789',
                                      idNumber: '',
                                    ),
                                  ],
                          );
                      if (context.mounted) {
                        setState(() => _isProcessing = false);
                        if (success) {
                          context.push(
                            '${RouteNames.paymentResult}?success=true',
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'Thanh toán thất bại, vui lòng thử lại!',
                              ),
                            ),
                          );
                        }
                      }
                    }
                  : null,
              child: _isProcessing
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  : Text(
                      'Thanh toán ${BookingProvider.formatVND(booking.grandTotal)}',
                    ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPriceRow(String label, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xxs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? AppTextStyles.titleSmall : AppTextStyles.bodySmall,
          ),
          Text(
            amount,
            style: isTotal
                ? AppTextStyles.titleLarge.copyWith(color: AppColors.primary)
                : AppTextStyles.label,
          ),
        ],
      ),
    );
  }
}

class _PaymentMethod {
  final String name;
  final IconData icon;
  final String description;
  final bool isSaved;

  const _PaymentMethod({
    required this.name,
    required this.icon,
    required this.description,
    this.isSaved = false,
  });
}
