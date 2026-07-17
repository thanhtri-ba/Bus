import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/di/injection.dart';
import 'package:busz/services/payment_method_service.dart';

class PaymentMethodsScreen extends StatefulWidget {
  const PaymentMethodsScreen({super.key});

  @override
  State<PaymentMethodsScreen> createState() => _PaymentMethodsScreenState();
}

class _PaymentMethodsScreenState extends State<PaymentMethodsScreen> {
  final PaymentMethodService _paymentMethodService = sl<PaymentMethodService>();
  List<PaymentMethodModel> _methods = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadMethods();
  }

  Future<void> _loadMethods() async {
    setState(() => _isLoading = true);
    try {
      final data = await _paymentMethodService.getPaymentMethods();
      setState(() => _methods = data);
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi tải dữ liệu: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Future<void> _deleteMethod(String id) async {
    try {
      await _paymentMethodService.deletePaymentMethod(id);
      _loadMethods();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Đã xóa phương thức thanh toán')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi xóa: $e')));
      }
    }
  }

  void _showAddMethodSheet() {
    String selectedType = 'MoMo';
    final infoController = TextEditingController();

    // Credit card specific controllers
    final cardholderController = TextEditingController();
    final cardNumberController = TextEditingController();
    final expiryController = TextEditingController();
    final cvvController = TextEditingController();

    bool isScanning = false;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (ctx, setModalState) {
            Future<void> mockScanCard() async {
              setModalState(() => isScanning = true);

              // Show scanning overlay dialog
              showDialog(
                context: bottomSheetContext,
                barrierDismissible: false,
                builder: (dialogCtx) => Dialog(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 280,
                            height: 180,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          // Simulated scanning line
                          TweenAnimationBuilder<double>(
                            tween: Tween(begin: -80, end: 80),
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOutSine,
                            builder: (context, value, child) {
                              return Transform.translate(
                                offset: Offset(0, value),
                                child: Container(
                                  width: 260,
                                  height: 4,
                                  color: AppColors.primary.withValues(
                                    alpha: 0.8,
                                  ),
                                ),
                              );
                            },
                            onEnd: () {
                              // Loop it roughly by the time we close
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      const Text(
                        'Đang quét thẻ...',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              );

              // Simulate delay for 2 seconds
              await Future.delayed(const Duration(seconds: 2));

              if (bottomSheetContext.mounted) {
                Navigator.pop(bottomSheetContext); // close dialog
              }

              setModalState(() {
                isScanning = false;
                cardholderController.text = "NGUYEN VAN A";
                cardNumberController.text = "4231 5678 9012 3456";
                expiryController.text = "12/28";
              });

              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Đã nhận diện thẻ thành công')),
                );
              }
            }

            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(bottomSheetContext).viewInsets.bottom,
                left: AppSpacing.lg,
                right: AppSpacing.lg,
                top: AppSpacing.lg,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thêm phương thức mới',
                      style: AppTextStyles.titleMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<String>(
                      initialValue: selectedType,
                      decoration: InputDecoration(
                        labelText: 'Loại phương thức',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'MoMo', child: Text('Ví MoMo')),
                        DropdownMenuItem(
                          value: 'ZaloPay',
                          child: Text('Ví ZaloPay'),
                        ),
                        DropdownMenuItem(
                          value: 'Visa',
                          child: Text('Thẻ tín dụng (Visa/Mastercard)'),
                        ),
                      ],
                      onChanged: (value) {
                        setModalState(() {
                          selectedType = value!;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),

                    if (selectedType != 'Visa') ...[
                      TextField(
                        controller: infoController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          labelText: 'Số điện thoại liên kết',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ] else ...[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Thông tin thẻ',
                            style: AppTextStyles.titleSmall,
                          ),
                          TextButton.icon(
                            onPressed: isScanning ? null : mockScanCard,
                            icon: const Icon(
                              Symbols.document_scanner_rounded,
                              size: 20,
                            ),
                            label: const Text('Quét thẻ'),
                          ),
                        ],
                      ),
                      const SizedBox(height: AppSpacing.sm),
                      TextField(
                        controller: cardNumberController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Số thẻ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Symbols.credit_card_rounded),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      TextField(
                        controller: cardholderController,
                        textCapitalization: TextCapitalization.characters,
                        decoration: InputDecoration(
                          labelText: 'Tên chủ thẻ',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          prefixIcon: const Icon(Symbols.person_rounded),
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: expiryController,
                              keyboardType: TextInputType.datetime,
                              decoration: InputDecoration(
                                labelText: 'Ngày hết hạn (MM/YY)',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: TextField(
                              controller: cvvController,
                              keyboardType: TextInputType.number,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'CVV',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],

                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isValid = false;
                          String infoToSave = '';

                          if (selectedType == 'Visa') {
                            if (cardNumberController.text.isNotEmpty &&
                                cardholderController.text.isNotEmpty) {
                              isValid = true;
                              // Mask the card number
                              String cardStr = cardNumberController.text
                                  .replaceAll(' ', '');
                              String masked = cardStr.length >= 4
                                  ? cardStr.substring(cardStr.length - 4)
                                  : cardStr;
                              infoToSave = '**** **** **** $masked';
                            }
                          } else {
                            if (infoController.text.isNotEmpty) {
                              isValid = true;
                              infoToSave = 'SĐT: ${infoController.text}';
                            }
                          }

                          if (isValid) {
                            final scaffoldMessenger = ScaffoldMessenger.of(
                              context,
                            );
                            final navigator = Navigator.of(bottomSheetContext);

                            try {
                              await _paymentMethodService.addPaymentMethod(
                                selectedType,
                                infoToSave,
                              );
                              _loadMethods();
                              navigator.pop();
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text(
                                    'Đã thêm phương thức thanh toán',
                                  ),
                                ),
                              );
                            } catch (e) {
                              navigator.pop();
                              scaffoldMessenger.showSnackBar(
                                SnackBar(content: Text('Lỗi thêm: $e')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Vui lòng nhập đầy đủ thông tin'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Lưu phương thức'),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxl),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Phương thức thanh toán')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _methods.isEmpty
          ? Center(
              child: Text(
                'Bạn chưa có phương thức thanh toán nào',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _methods.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final method = _methods[index];
                return _buildPaymentMethodItem(method);
              },
            ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: ElevatedButton.icon(
            onPressed: _showAddMethodSheet,
            icon: const Icon(Symbols.add_rounded),
            label: const Text('Thêm phương thức mới'),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPaymentMethodItem(PaymentMethodModel method) {
    IconData icon = Symbols.credit_card_rounded;
    Color iconColor = Colors.blue;

    if (method.type == 'MoMo') {
      icon = Symbols.account_balance_wallet_rounded;
      iconColor = Colors.pink;
    } else if (method.type == 'ZaloPay') {
      icon = Symbols.account_balance_wallet_rounded;
      iconColor = Colors.green;
    }

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        leading: Icon(icon, color: iconColor, size: 32),
        title: Text(
          method.type == 'Visa' ? 'Thẻ tín dụng (Visa)' : 'Ví ${method.type}',
          style: AppTextStyles.titleSmall,
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(method.info, style: AppTextStyles.bodyMedium),
        ),
        trailing: TextButton(
          onPressed: () => _deleteMethod(method.id),
          style: TextButton.styleFrom(foregroundColor: AppColors.error),
          child: const Text('Xóa'),
        ),
      ),
    );
  }
}
