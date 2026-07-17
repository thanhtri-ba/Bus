import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/theme/app_text_styles.dart';
import 'package:busz/core/theme/app_spacing.dart';
import 'package:busz/core/theme/app_radius.dart';
import 'package:busz/core/di/injection.dart';
import 'package:busz/services/address_service.dart';
import 'package:dvhcvn/dvhcvn.dart' as dvhcvn;

class MyAddressScreen extends StatefulWidget {
  const MyAddressScreen({super.key});

  @override
  State<MyAddressScreen> createState() => _MyAddressScreenState();
}

class _MyAddressScreenState extends State<MyAddressScreen> {
  final AddressService _addressService = sl<AddressService>();
  List<AddressModel> _addresses = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadAddresses();
  }

  Future<void> _loadAddresses() async {
    setState(() => _isLoading = true);
    try {
      final data = await _addressService.getAddresses();
      setState(() => _addresses = data);
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

  Future<void> _deleteAddress(String id) async {
    try {
      await _addressService.deleteAddress(id);
      _loadAddresses();
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Đã xóa địa chỉ')));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Lỗi xóa: $e')));
      }
    }
  }

  void _showAddAddressSheet() {
    final titleController = TextEditingController();
    final houseController = TextEditingController();
    final countryController = TextEditingController(text: 'Việt Nam');

    dvhcvn.Level1? selectedProvince;
    dvhcvn.Level2? selectedDistrict;
    dvhcvn.Level3? selectedWard;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return StatefulBuilder(
          builder: (context, setSheetState) {
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
                    Text('Thêm địa chỉ mới', style: AppTextStyles.titleMedium),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Tên địa chỉ (VD: Nhà riêng, Công ty)',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: houseController,
                      decoration: InputDecoration(
                        labelText: 'Số nhà, Tên đường',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    DropdownButtonFormField<dvhcvn.Level1>(
                      isExpanded: true,
                      decoration: InputDecoration(
                        labelText: 'Tỉnh/Thành phố',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      initialValue: selectedProvince,
                      items: dvhcvn.level1s
                          .map(
                            (e) => DropdownMenuItem(
                              value: e,
                              child: Text(
                                e.name,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          )
                          .toList(),
                      onChanged: (val) {
                        setSheetState(() {
                          selectedProvince = val;
                          selectedDistrict = null;
                          selectedWard = null;
                        });
                      },
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<dvhcvn.Level2>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: 'Quận/Huyện',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            initialValue: selectedDistrict,
                            items:
                                selectedProvince?.children
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: selectedProvince == null
                                ? null
                                : (val) {
                                    setSheetState(() {
                                      selectedDistrict = val;
                                      selectedWard = null;
                                    });
                                  },
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: DropdownButtonFormField<dvhcvn.Level3>(
                            isExpanded: true,
                            decoration: InputDecoration(
                              labelText: 'Phường/Xã',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            initialValue: selectedWard,
                            items:
                                selectedDistrict?.children
                                    .map(
                                      (e) => DropdownMenuItem(
                                        value: e,
                                        child: Text(
                                          e.name,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                    )
                                    .toList() ??
                                [],
                            onChanged: selectedDistrict == null
                                ? null
                                : (val) {
                                    setSheetState(() {
                                      selectedWard = val;
                                    });
                                  },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                    TextField(
                      controller: countryController,
                      decoration: InputDecoration(
                        labelText: 'Quốc gia',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty &&
                              houseController.text.isNotEmpty &&
                              selectedProvince != null &&
                              selectedDistrict != null &&
                              selectedWard != null) {
                            final scaffoldMessenger = ScaffoldMessenger.of(
                              context,
                            );
                            final navigator = Navigator.of(bottomSheetContext);

                            final parts = [
                              houseController.text.trim(),
                              selectedWard!.name,
                              selectedDistrict!.name,
                              selectedProvince!.name,
                              countryController.text.trim(),
                            ].where((p) => p.isNotEmpty).join(', ');

                            try {
                              await _addressService.addAddress(
                                titleController.text,
                                parts,
                              );
                              _loadAddresses();
                              navigator.pop();
                              scaffoldMessenger.showSnackBar(
                                const SnackBar(
                                  content: Text('Đã thêm địa chỉ mới'),
                                ),
                              );
                            } catch (e) {
                              navigator.pop();
                              scaffoldMessenger.showSnackBar(
                                SnackBar(content: Text('Lỗi thêm địa chỉ: $e')),
                              );
                            }
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Vui lòng nhập và chọn đủ thông tin địa chỉ',
                                ),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        child: const Text('Lưu địa chỉ'),
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
      appBar: AppBar(title: const Text('Địa chỉ của tôi')),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _addresses.isEmpty
          ? Center(
              child: Text(
                'Bạn chưa có địa chỉ nào',
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.textSecondary,
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.md),
              itemCount: _addresses.length,
              separatorBuilder: (context, index) =>
                  const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final address = _addresses[index];
                return _buildAddressItem(address);
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddAddressSheet,
        child: const Icon(Symbols.add_rounded),
      ),
    );
  }

  Widget _buildAddressItem(AddressModel address) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: AppRadius.card,
        border: Border.all(color: Theme.of(context).dividerColor),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.primaryContainer.withValues(alpha: 0.3),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Symbols.location_on_rounded,
            color: AppColors.primary,
          ),
        ),
        title: Row(
          children: [
            Expanded(
              child: Text(
                address.title,
                style: AppTextStyles.titleSmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            if (address.isDefault) ...[
              const SizedBox(width: AppSpacing.sm),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: AppRadius.pillAll,
                ),
                child: Text(
                  'Mặc định',
                  style: AppTextStyles.captionSmall.copyWith(
                    color: AppColors.primary,
                  ),
                ),
              ),
            ],
          ],
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 4.0),
          child: Text(address.address, style: AppTextStyles.bodyMedium),
        ),
        trailing: PopupMenuButton<String>(
          icon: const Icon(Symbols.more_vert_rounded),
          onSelected: (value) {
            if (value == 'delete') {
              _deleteAddress(address.id);
            }
          },
          itemBuilder: (context) => [
            const PopupMenuItem(value: 'edit', child: Text('Sửa')),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Xóa', style: TextStyle(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );
  }
}
