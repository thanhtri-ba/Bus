import 'package:flutter/material.dart';
import 'package:busz/models/home_models.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'active_ticket_barcode_sheet.dart';

class ActiveTicketCard extends StatelessWidget {
  final Ticket ticket;

  const ActiveTicketCard({super.key, required this.ticket});

  void _showBarcodeSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withValues(alpha: 0.7),
      enableDrag: true,
      isDismissible: true,
      builder: (context) => ActiveTicketBarcodeSheet(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: const Color(0xFFD0D5DD)),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            ticket.boardingTime.isNotEmpty
                ? ticket.boardingTime
                : 'Unknown Date',
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w500,
              fontSize: 14,
              height: 1.42,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildBadge(
                'Fastest',
                const Color(0xFFDC6803),
                Colors.white,
                Colors.transparent,
              ),
              const SizedBox(width: 8),
              _buildBadge(
                'Mix',
                const Color(0xFFF9FAFB),
                const Color(0xFF344054),
                const Color(0xFFEAECF0),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildRouteTimeline(),
          const SizedBox(height: 16),
          _buildBusInfo(),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => _showBarcodeSheet(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF1570EF),
                padding: const EdgeInsets.symmetric(vertical: 10),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                elevation: 0,
              ),
              child: const Text(
                'Lihat Barcode',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  height: 1.42,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBadge(
    String text,
    Color bgColor,
    Color textColor,
    Color borderColor,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(
          color: borderColor == Colors.transparent ? bgColor : borderColor,
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: textColor,
        ),
      ),
    );
  }

  Widget _buildRouteTimeline() {
    return Row(
      children: [
        // Origin
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFF16B364),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.location_on_rounded,
                  size: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Halte',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xFF667085),
                ),
              ),
              Text(
                ticket.departureStation,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF101828),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        // Line and Duration
        Expanded(
          flex: 3,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFF9FAFB),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: const Color(0xFFEAECF0)),
                ),
                child: Text(
                  'Est. ${ticket.duration}',
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w600,
                    fontSize: 8,
                    color: Color(0xFF344054),
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Container(height: 1, color: const Color(0xFFEAECF0)),
            ],
          ),
        ),
        // Destination
        Expanded(
          flex: 2,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: const BoxDecoration(
                  color: Color(0xFFF79009), // Orange
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Symbols.location_on_rounded,
                  size: 10,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 4),
              const Text(
                'Halte',
                style: TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 10,
                  color: Color(0xFF667085),
                ),
              ),
              Text(
                ticket.arrivalStation,
                style: const TextStyle(
                  fontFamily: 'Poppins',
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  height: 1.5,
                  color: Color(0xFF101828),
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.right,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildBusInfo() {
    return Row(
      children: [
        const Icon(
          Symbols.directions_bus_rounded,
          size: 16,
          color: Color(0xFF475467),
        ),
        const SizedBox(width: 4),
        Text(
          ticket.busAgent.isNotEmpty ? ticket.busAgent : 'Bus',
          style: const TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: Color(0xFF475467),
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text.rich(
            TextSpan(
              text: 'Arrival in ',
              children: [
                TextSpan(
                  text: ticket.arrivalTime,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                TextSpan(text: ' at ${ticket.arrivalStation}'),
              ],
            ),
            style: const TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w400,
              fontSize: 12,
              height: 1.5,
              color: Color(0xFF475467),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
