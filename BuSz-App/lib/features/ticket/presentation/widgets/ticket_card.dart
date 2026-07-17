import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:busz/models/home_models.dart';
import 'package:busz/core/theme/app_colors.dart';
import 'package:busz/core/widgets/bounce_widget.dart';

class TicketClipper extends CustomClipper<Path> {
  final double holeRadius;
  final double offset; // Offset from bottom

  TicketClipper({this.holeRadius = 14, this.offset = 74});

  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);

    path.addOval(
      Rect.fromCircle(
        center: Offset(0, size.height - offset),
        radius: holeRadius,
      ),
    );
    path.addOval(
      Rect.fromCircle(
        center: Offset(size.width, size.height - offset),
        radius: holeRadius,
      ),
    );

    path.fillType = PathFillType.evenOdd;
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class DashedLine extends StatelessWidget {
  final Color color;
  const DashedLine({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final boxWidth = constraints.constrainWidth();
        const dashWidth = 8.0;
        const dashHeight = 1.5;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();
        return Flex(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          direction: Axis.horizontal,
          children: List.generate(dashCount, (_) {
            return SizedBox(
              width: dashWidth,
              height: dashHeight,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

class TicketCard extends StatefulWidget {
  final Ticket ticket;
  final VoidCallback onTap;

  const TicketCard({super.key, required this.ticket, required this.onTap});

  @override
  State<TicketCard> createState() => _TicketCardState();
}

class _TicketCardState extends State<TicketCard> {
  Timer? _timer;
  Duration _remainingTime = Duration.zero;

  @override
  void initState() {
    super.initState();
    if (widget.ticket.status == TicketStatus.waitingPayment &&
        widget.ticket.paymentExpiresAt != null) {
      _calculateRemainingTime();
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        _calculateRemainingTime();
      });
    }
  }

  void _calculateRemainingTime() {
    if (widget.ticket.paymentExpiresAt == null) return;
    final now = DateTime.now();
    final difference = widget.ticket.paymentExpiresAt!.difference(now);

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

  @override
  Widget build(BuildContext context) {
    final bool isWaitingPayment =
        widget.ticket.status == TicketStatus.waitingPayment &&
        _remainingTime > Duration.zero;
    final bool isPaymentExpired =
        widget.ticket.status == TicketStatus.paymentExpired ||
        (widget.ticket.status == TicketStatus.waitingPayment &&
            _remainingTime <= Duration.zero);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final TicketStatus displayStatus = isPaymentExpired
        ? TicketStatus.paymentExpired
        : widget.ticket.status;

    return BounceWidget(
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.4)
                  : AppColors.primary.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipPath(
          clipper: TicketClipper(),
          child: Container(
            color: isDark ? AppColors.darkCard : Colors.white,
            child: Column(
              children: [
                // TOP SECTION
                Container(
                  decoration: BoxDecoration(
                    gradient: isDark
                        ? null
                        : const LinearGradient(
                            colors: [Colors.white, Color(0xFFF8FAFC)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                  ),
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: AppColors.primary.withValues(
                                    alpha: 0.1,
                                  ),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: const Icon(
                                  Symbols.directions_bus_rounded,
                                  color: AppColors.primary,
                                  size: 18,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Text(
                                widget.ticket.busAgent,
                                style: const TextStyle(
                                  fontWeight: FontWeight.w900,
                                  fontSize: 16,
                                  letterSpacing: -0.3,
                                ),
                              ),
                            ],
                          ),
                          _buildStatusBadge(displayStatus),
                        ],
                      ),
                      const SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Điểm đi',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.white54
                                        : const Color(0xFF64748B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.ticket.departureStation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  DateFormat(
                                    'dd/MM/yyyy',
                                  ).format(widget.ticket.date),
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryLight,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Symbols.arrow_forward_rounded,
                                    color: AppColors.primary,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  widget.ticket.duration,
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.white54
                                        : const Color(0xFF64748B),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  'Điểm đến',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: isDark
                                        ? Colors.white54
                                        : const Color(0xFF64748B),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  widget.ticket.arrivalStation,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                    fontSize: 18,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  textAlign: TextAlign.right,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  widget.ticket.arrivalTime,
                                  style: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                // DIVIDER SECTION
                SizedBox(
                  height: 28, // Height for the holes
                  child: Row(
                    children: [
                      const SizedBox(width: 14),
                      Expanded(
                        child: DashedLine(
                          color: isDark
                              ? Colors.white24
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      const SizedBox(width: 14),
                    ],
                  ),
                ),

                // BOTTOM SECTION
                Container(
                  decoration: BoxDecoration(
                    color: isDark ? Colors.black12 : const Color(0xFFF8FAFC),
                  ),
                  padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Mã vé',
                            style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? Colors.white54
                                  : const Color(0xFF64748B),
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            widget.ticket.id.substring(0, 8).toUpperCase(),
                            style: const TextStyle(
                              fontFamily: 'Monospace',
                              fontWeight: FontWeight.w900,
                              fontSize: 16,
                              letterSpacing: 1.0,
                            ),
                          ),
                        ],
                      ),
                      if (isWaitingPayment)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.deepOrange.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Symbols.timer_rounded,
                                color: Colors.deepOrange,
                                size: 16,
                              ),
                              const SizedBox(width: 6),
                              Text(
                                _formatDuration(_remainingTime),
                                style: const TextStyle(
                                  color: Colors.deepOrange,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (displayStatus == TicketStatus.active)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 8,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.primary.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: const Row(
                            children: [
                              Icon(
                                Symbols.qr_code_rounded,
                                color: Colors.white,
                                size: 16,
                              ),
                              SizedBox(width: 6),
                              Text(
                                'Xem vé',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                        )
                      else if (displayStatus == TicketStatus.paymentExpired ||
                          displayStatus == TicketStatus.canceled)
                        const Text(
                          'Đã hủy',
                          style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.w800,
                            fontSize: 14,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusBadge(TicketStatus status) {
    Color bgColor, textColor;
    String text;

    switch (status) {
      case TicketStatus.active:
        text = 'Đã thanh toán';
        bgColor = const Color(0xFFE6F4EA);
        textColor = const Color(0xFF1E8E3E);
        break;
      case TicketStatus.waitingPayment:
        text = 'Chờ thanh toán';
        bgColor = const Color(0xFFFEF7E0);
        textColor = const Color(0xFFF29900);
        break;
      case TicketStatus.canceled:
      case TicketStatus.paymentExpired:
        text = 'Đã hủy';
        bgColor = const Color(0xFFFCE8E6);
        textColor = const Color(0xFFD93025);
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: textColor.withValues(alpha: 0.2)),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w800,
          fontSize: 11,
          color: textColor,
        ),
      ),
    );
  }
}
