/// BusZ — Booking Summary Screen
///
/// Source of Truth: BusZ-Documentation/06_Flutter/07_Booking_Module.md §10-11
///
/// Displays all booking details before payment:
/// - Route, bus company, seats, passengers
/// - Pickup/Dropoff points
/// - Price breakdown (ticket, discount, service fee, total)
/// - Promotion code input
/// - Confirmation dialog
library;

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
import 'package:busz/services/address_service.dart';
import 'package:busz/core/di/injection.dart';

class BookingSummaryScreen extends StatefulWidget {
  const BookingSummaryScreen({super.key});

  @override
  State<BookingSummaryScreen> createState() => _BookingSummaryScreenState();
}

class _BookingSummaryScreenState extends State<BookingSummaryScreen> {
  final _promoController = TextEditingController();

  @override
  void dispose() {
    _promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tóm tắt đặt vé'),
        leading: IconButton(
          icon: const Icon(Symbols.arrow_back_ios_new_rounded, size: 18),
          onPressed: () => context.pop(),
        ),
      ),
      body: Consumer<BookingProvider>(
        builder: (context, booking, _) {
          final trip = booking.selectedTrip;
          return SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Trip Info Card
                _buildSection(
                  'Thông tin chuyến xe',
                  Symbols.directions_bus_rounded,
                  child: Column(
                    children: [
                      _buildInfoRow('Nhà xe', trip?.company ?? 'Chưa chọn'),
                      _buildInfoRow('Loại xe', trip?.busType ?? '—'),
                      _buildInfoRow(
                        'Ngày đi',
                        booking.travelDate.isEmpty
                            ? 'Hôm nay'
                            : booking.travelDate,
                      ),
                      const Divider(height: AppSpacing.xl),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  trip?.departureTime ?? '——:——',
                                  style: AppTextStyles.titleSmall,
                                ),
                                Text(
                                  trip?.departureStation ?? booking.departure,
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              const Icon(
                                Symbols.arrow_forward_rounded,
                                size: 16,
                                color: AppColors.primary,
                              ),
                              Text(
                                trip?.duration ?? '',
                                style: AppTextStyles.captionSmall,
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  trip?.arrivalTime ?? '——:——',
                                  style: AppTextStyles.titleSmall,
                                ),
                                Text(
                                  trip?.arrivalStation ?? booking.destination,
                                  style: AppTextStyles.caption,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Seats & Passengers
                _buildSection(
                  'Ghế & Hành khách',
                  Symbols.event_seat_rounded,
                  child: Column(
                    children: [
                      if (booking.passengers.isEmpty) ...[
                        _buildPassengerRow(
                          booking.selectedSeats.isNotEmpty
                              ? booking.selectedSeats.first
                              : 'Ghế',
                          booking.contactName.isEmpty
                              ? 'Hành khách'
                              : booking.contactName,
                          booking.contactPhone,
                        ),
                      ] else ...[
                        ...List.generate(booking.passengers.length, (i) {
                          final p = booking.passengers[i];
                          final seatLabel = i < booking.selectedSeats.length
                              ? booking.selectedSeats[i]
                              : 'Ghế ${i + 1}';
                          return Column(
                            children: [
                              if (i > 0) const Divider(height: AppSpacing.md),
                              _buildPassengerRow(seatLabel, p.name, p.phone),
                            ],
                          );
                        }),
                      ],
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Pickup / Dropoff
                _buildSection(
                  'Điểm đón & trả',
                  Symbols.location_on_rounded,
                  action: TextButton(
                    onPressed: () => _showAddressSelectionSheet(context),
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(0, 0),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      'Thay đổi',
                      style: AppTextStyles.labelSmall.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  child: Column(
                    children: [
                      _buildLocationRow(
                        'Điểm đón',
                        trip?.departureStation ?? booking.departure,
                        trip?.departureTime ?? '',
                      ),
                      const Divider(height: AppSpacing.md),
                      _buildLocationRow(
                        'Điểm trả',
                        booking.customDropoffAddress.isNotEmpty
                            ? booking.customDropoffAddress
                            : (trip?.arrivalStation ?? booking.destination),
                        booking.customDropoffAddress.isNotEmpty
                            ? ''
                            : (trip?.arrivalTime ?? ''),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Promotion
                _buildSection(
                  'Mã giảm giá',
                  Symbols.local_offer_rounded,
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _promoController,
                          decoration: const InputDecoration(
                            hintText: 'Nhập mã giảm giá',
                            isDense: true,
                          ),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      OutlinedButton(
                        onPressed: () {
                          context.read<BookingProvider>().applyPromo(
                            _promoController.text,
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size(80, 48),
                        ),
                        child: const Text('Áp dụng'),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.md),

                // Price Breakdown
                _buildSection(
                  'Chi tiết thanh toán',
                  Symbols.receipt_long_rounded,
                  child: Column(
                    children: [
                      _buildPriceRow(
                        'Giá vé (${booking.seatCount} ghế)',
                        BookingProvider.formatVND(booking.ticketTotal),
                      ),
                      if (booking.discountAmount > 0)
                        _buildPriceRow(
                          'Giảm giá',
                          '-${BookingProvider.formatVND(booking.discountAmount)}',
                          isDiscount: true,
                        ),
                      _buildPriceRow(
                        'Phí dịch vụ',
                        BookingProvider.formatVND(BookingProvider.serviceFee),
                      ),
                      const Divider(height: AppSpacing.xl),
                      _buildPriceRow(
                        'Tổng cộng',
                        BookingProvider.formatVND(booking.grandTotal),
                        isTotal: true,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 100),
              ],
            ),
          );
        },
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
          child: ElevatedButton(
            onPressed: _showConfirmDialog,
            child: Consumer<BookingProvider>(
              builder: (context, booking, _) => Text(
                'Đặt vé - ${BookingProvider.formatVND(booking.grandTotal)}',
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showConfirmDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận đặt vé?'),
        content: const Text(
          'Bạn sẽ được chuyển sang trang thanh toán sau khi xác nhận.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('Quay lại'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              context.push(RouteNames.payment);
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(120, 44)),
            child: const Text('Tiếp tục thanh toán'),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    IconData icon, {
    required Widget child,
    Widget? action,
  }) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surfaceCard,
        borderRadius: AppRadius.card,
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 20, color: AppColors.primary),
              const SizedBox(width: AppSpacing.xs),
              Expanded(child: Text(title, style: AppTextStyles.titleSmall)),
              ?action,
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }

  void _showAddressSelectionSheet(BuildContext context) {
    final addressService = sl<AddressService>();
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return FutureBuilder<List<AddressModel>>(
          future: addressService.getAddresses(),
          builder: (ctx, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                height: 200,
                child: Center(child: CircularProgressIndicator()),
              );
            }
            final addresses = snapshot.data ?? [];
            return Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Chọn điểm trả', style: AppTextStyles.titleMedium),
                      TextButton(
                        onPressed: () {
                          Navigator.pop(ctx);
                          context.push(RouteNames.myAddress);
                        },
                        child: const Text('Quản lý'),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  if (addresses.isEmpty)
                    const Padding(
                      padding: EdgeInsets.all(AppSpacing.md),
                      child: Text('Bạn chưa lưu địa chỉ nào.'),
                    )
                  else
                    ...addresses.map(
                      (addr) => ListTile(
                        leading: const Icon(
                          Symbols.location_on_rounded,
                          color: AppColors.primary,
                        ),
                        title: Text(addr.title, style: AppTextStyles.label),
                        subtitle: Text(
                          addr.address,
                          style: AppTextStyles.caption,
                        ),
                        contentPadding: EdgeInsets.zero,
                        onTap: () {
                          context
                              .read<BookingProvider>()
                              .setCustomDropoffAddress(addr.address);
                          Navigator.pop(ctx);
                        },
                      ),
                    ),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: AppTextStyles.bodySmall),
          Text(value, style: AppTextStyles.label),
        ],
      ),
    );
  }

  Widget _buildPassengerRow(String seat, String name, String phone) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.secondaryLight,
            borderRadius: AppRadius.smallAll,
          ),
          child: Text(
            seat,
            style: AppTextStyles.labelSmall.copyWith(
              color: AppColors.secondary,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: AppTextStyles.label),
              Text(phone, style: AppTextStyles.caption),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLocationRow(String label, String station, String time) {
    return Row(
      children: [
        Icon(
          label == 'Điểm đón'
              ? Symbols.trip_origin_rounded
              : Symbols.place_rounded,
          size: 20,
          color: label == 'Điểm đón'
              ? AppColors.routeDeparture
              : AppColors.routeArrival,
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: AppTextStyles.caption),
              Text(station, style: AppTextStyles.label),
            ],
          ),
        ),
        Text(time, style: AppTextStyles.titleSmall),
      ],
    );
  }

  Widget _buildPriceRow(
    String label,
    String amount, {
    bool isDiscount = false,
    bool isTotal = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.xs),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal
                ? AppTextStyles.titleSmall
                : AppTextStyles.bodyMedium,
          ),
          Text(
            amount,
            style: isTotal
                ? AppTextStyles.titleLarge.copyWith(color: AppColors.primary)
                : isDiscount
                ? AppTextStyles.label.copyWith(color: AppColors.success)
                : AppTextStyles.label,
          ),
        ],
      ),
    );
  }
}
