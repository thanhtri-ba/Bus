import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/models/home_models.dart';
import 'package:busz/services/ticket_service.dart';
import 'package:busz/core/theme/app_colors.dart';

class TicketDetailScreen extends StatefulWidget {
  final String ticketId;

  const TicketDetailScreen({super.key, required this.ticketId});

  @override
  State<TicketDetailScreen> createState() => _TicketDetailScreenState();
}

class _TicketDetailScreenState extends State<TicketDetailScreen> {
  Ticket? _ticket;
  bool _isLoading = true;
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    setState(() => _isLoading = true);
    try {
      final ticket = await TicketService.getTicketById(widget.ticketId);
      if (mounted) {
        setState(() {
          _ticket = ticket;
          _isLoading = false;
          if (_ticket?.status == TicketStatus.waitingPayment &&
              _ticket?.paymentExpiresAt != null) {
            _calculateRemainingTime();
            _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
              _calculateRemainingTime();
            });
          }
        });
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _calculateRemainingTime() {
    if (_ticket?.paymentExpiresAt == null) return;
    final now = DateTime.now();
    final difference = _ticket!.paymentExpiresAt!.difference(now);

    if (difference.isNegative) {
      _timer?.cancel();
      if (mounted) setState(() => _remainingTime = Duration.zero);
    } else {
      if (mounted) setState(() => _remainingTime = difference);
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return hours != '00' ? '$hours:$minutes:$seconds' : '$minutes:$seconds';
  }

  final _currencyFormat = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: '₫',
    decimalDigits: 0,
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? AppColors.darkBackground : const Color(0xFFF8FAFC);

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark,
      child: Scaffold(
        backgroundColor: bgColor,
        appBar: AppBar(
          backgroundColor: bgColor,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: Icon(
              Symbols.arrow_back_ios_new_rounded,
              size: 20,
              color: isDark ? Colors.white : const Color(0xFF101828),
            ),
            onPressed: () => context.pop(),
          ),
          title: Text(
            'Chi tiết vé',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: -0.5,
              color: isDark ? Colors.white : const Color(0xFF101828),
            ),
          ),
          centerTitle: true,
        ),
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(color: AppColors.primary),
              )
            : _ticket == null
            ? const Center(
                child: Text(
                  'Không tìm thấy vé',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
              )
            : Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(bottom: 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildQRSection(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildTripSummary(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildTrackBus(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildJourney(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildCustomerInfo(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildProtection(_ticket!, isDark),
                        _buildDivider(isDark),
                        _buildPaymentDetails(_ticket!, isDark),
                      ],
                    ),
                  ),
                  if (_ticket != null && !_isLoading)
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: _buildFloatingBottomBar(isDark),
                    ),
                ],
              ),
      ),
    );
  }

  Widget _buildFloatingBottomBar(bool isDark) {
    if (_ticket!.status == TicketStatus.active) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white10 : const Color(0xFFEAECF0),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        'Xác nhận dịch vụ thành công!',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                      backgroundColor: Color(0xFF16B364),
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  'Xác nhận lên xe',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
              ),
            ),
          ),
        ),
      );
    }

    final bool isWaitingPayment =
        _ticket!.status == TicketStatus.waitingPayment &&
        _remainingTime > Duration.zero;
    final bool isPaymentExpired =
        _ticket!.status == TicketStatus.paymentExpired ||
        (_ticket!.status == TicketStatus.waitingPayment &&
            _remainingTime <= Duration.zero);

    if (isWaitingPayment || isPaymentExpired) {
      return ClipRRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.8),
              border: Border(
                top: BorderSide(
                  color: isDark ? Colors.white10 : const Color(0xFFEAECF0),
                ),
              ),
            ),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: isWaitingPayment
                    ? () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Đang chuyển đến cổng thanh toán...',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            backgroundColor: AppColors.primary,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isWaitingPayment
                      ? AppColors.primary
                      : (isDark
                            ? Colors.grey.shade800
                            : const Color(0xFFF2F4F7)),
                  foregroundColor: isWaitingPayment
                      ? Colors.white
                      : const Color(0xFF98A2B3),
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Text(
                  isWaitingPayment
                      ? 'Thanh toán ngay (${_formatDuration(_remainingTime)})'
                      : 'Đã hết hạn thanh toán',
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 15,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }

  Widget _buildDivider(bool isDark) {
    return Container(
      height: 8,
      width: double.infinity,
      color: isDark ? Colors.black12 : const Color(0xFFF1F5F9),
    );
  }

  Widget _buildQRSection(Ticket ticket, bool isDark) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        children: [
          const Text(
            'Vé điện tử của bạn',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 18,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
                width: 2,
              ),
            ),
            child: QrImageView(
              data: ticket.bookingCode,
              version: QrVersions.auto,
              size: 200,
              gapless: true,
              eyeStyle: const QrEyeStyle(
                eyeShape: QrEyeShape.square,
                color: Colors.black,
              ),
              dataModuleStyle: const QrDataModuleStyle(
                dataModuleShape: QrDataModuleShape.square,
                color: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Mã Đặt Chỗ',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: isDark ? Colors.white54 : const Color(0xFF64748B),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            ticket.bookingCode,
            style: const TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 24,
              letterSpacing: 2.0,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Quét mã QR hoặc đưa mã đặt chỗ cho lơ xe khi lên xe.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 13,
              color: isDark ? Colors.white54 : const Color(0xFF64748B),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTripSummary(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat('EEEE, dd/MM/yyyy').format(ticket.date),
                style: const TextStyle(
                  fontWeight: FontWeight.w800,
                  fontSize: 16,
                ),
              ),
              Row(
                children: [
                  _buildTripBadge(ticket.busClass, isPrimary: true),
                  const SizedBox(width: 8),
                  _buildTripBadge(ticket.type, isPrimary: false),
                ],
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFF16B364).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Symbols.trip_origin_rounded,
                        color: Color(0xFF16B364),
                        size: 14,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Điểm đi',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: isDark
                                  ? Colors.white54
                                  : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ticket.departureStation,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    const Icon(
                      Symbols.arrow_forward_rounded,
                      color: AppColors.primary,
                      size: 20,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      ticket.duration,
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 11,
                        color: isDark
                            ? Colors.white54
                            : const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Điểm đến',
                            style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: isDark
                                  ? Colors.white54
                                  : const Color(0xFF64748B),
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            ticket.arrivalStation,
                            style: const TextStyle(
                              fontWeight: FontWeight.w800,
                              fontSize: 14,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF79009).withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Symbols.trip_origin_rounded,
                        color: Color(0xFFF79009),
                        size: 14,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Icon(
                    Symbols.directions_bus_rounded,
                    color: AppColors.primary,
                    size: 18,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    ticket.busAgent,
                    style: const TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: 14,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text.rich(
                  TextSpan(
                    text: 'Đến lúc ',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                      color: isDark ? Colors.white70 : const Color(0xFF475467),
                    ),
                    children: [
                      TextSpan(
                        text: ticket.arrivalTime,
                        style: const TextStyle(fontWeight: FontWeight.w800),
                      ),
                      TextSpan(text: ' tại ${ticket.arrivalStation}'),
                    ],
                  ),
                  textAlign: TextAlign.right,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTripBadge(String text, {required bool isPrimary}) {
    if (text.isEmpty) return const SizedBox.shrink();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: isPrimary ? AppColors.primary : AppColors.primaryLight,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: 11,
          color: isPrimary ? Colors.white : AppColors.primary,
        ),
      ),
    );
  }

  Widget _buildTrackBus(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Định vị xe',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            height: 140,
            width: double.infinity,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF1F5F9),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Symbols.map_rounded,
                    color: AppColors.primary.withValues(alpha: 0.5),
                    size: 32,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Bản đồ đang được cập nhật',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: isDark ? Colors.white54 : const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildJourney(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Hành trình',
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 16,
                  letterSpacing: -0.5,
                ),
              ),
              Icon(
                Symbols.expand_more_rounded,
                color: AppColors.primary,
                size: 24,
              ),
            ],
          ),
          if (ticket.journeySegments != null &&
              ticket.journeySegments!.isNotEmpty) ...[
            const SizedBox(height: 24),
            ...ticket.journeySegments!.asMap().entries.map((entry) {
              final index = entry.key;
              final segment = entry.value;
              final isLast = index == ticket.journeySegments!.length - 1;
              return _buildJourneySegment(segment, isLast, isDark);
            }),
          ],
        ],
      ),
    );
  }

  Widget _buildJourneySegment(
    JourneySegment segment,
    bool isLast,
    bool isDark,
  ) {
    IconData iconData;
    Color iconColor;
    Color iconBg;
    if (segment.iconType == 'walking') {
      iconData = Symbols.directions_walk_rounded;
      iconColor = const Color(0xFF16B364);
      iconBg = const Color(0xFF16B364).withValues(alpha: 0.1);
    } else if (segment.iconType == 'bus') {
      iconData = Symbols.directions_bus_rounded;
      iconColor = AppColors.primary;
      iconBg = AppColors.primary.withValues(alpha: 0.1);
    } else {
      iconData = Symbols.trip_origin_rounded;
      iconColor = const Color(0xFFF79009);
      iconBg = const Color(0xFFF79009).withValues(alpha: 0.1);
    }

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: segment.iconType == 'destination'
                      ? Colors.transparent
                      : iconBg,
                  shape: BoxShape.circle,
                ),
                child: Icon(iconData, size: 18, color: iconColor),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 28.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    segment.title,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 13,
                      color: isDark ? Colors.white70 : const Color(0xFF64748B),
                    ),
                  ),
                  if (segment.subtitle != null) ...[
                    const SizedBox(height: 4),
                    Text(
                      segment.subtitle!,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                  if (segment.durationBadge != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFF1E293B)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        segment.durationBadge!,
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 11,
                          color: isDark
                              ? Colors.white70
                              : const Color(0xFF475467),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCustomerInfo(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Thông tin hành khách',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1E293B) : const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Icon(
                      Symbols.person_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.passengerName,
                      style: const TextStyle(
                        fontWeight: FontWeight.w800,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Symbols.mail_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.passengerEmail,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF475467),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    const Icon(
                      Symbols.call_rounded,
                      size: 18,
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      ticket.passengerPhone,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                        color: isDark
                            ? Colors.white70
                            : const Color(0xFF475467),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProtection(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF16B364).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Symbols.health_and_safety_rounded,
              color: Color(0xFF16B364),
              size: 24,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Bảo hiểm chuyến đi',
                  style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  'Bạn đã được bảo vệ bởi bảo hiểm của chúng tôi.',
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                    color: isDark ? Colors.white54 : const Color(0xFF64748B),
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Xem chi tiết',
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentDetails(Ticket ticket, bool isDark) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      color: isDark ? AppColors.darkCard : Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Chi tiết thanh toán',
            style: TextStyle(
              fontWeight: FontWeight.w900,
              fontSize: 16,
              letterSpacing: -0.5,
            ),
          ),
          const SizedBox(height: 20),
          _buildPaymentRow(
            'Giá vé',
            _currencyFormat.format(ticket.ticketPrice),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _buildPaymentRow(
            'Phí dịch vụ',
            _currencyFormat.format(ticket.convenienceFee),
            isDark: isDark,
          ),
          const SizedBox(height: 16),
          Container(
            height: 1,
            color: isDark ? Colors.white10 : const Color(0xFFE2E8F0),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Tổng thanh toán',
                style: TextStyle(fontWeight: FontWeight.w900, fontSize: 15),
              ),
              Text(
                _currencyFormat.format(ticket.totalAmount),
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentRow(
    String label,
    String value, {
    bool isDiscount = false,
    required bool isDark,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 14,
            color: isDark ? Colors.white70 : const Color(0xFF64748B),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 14,
            color: isDiscount
                ? const Color(0xFF16B364)
                : (isDark ? Colors.white : const Color(0xFF101828)),
          ),
        ),
      ],
    );
  }
}
