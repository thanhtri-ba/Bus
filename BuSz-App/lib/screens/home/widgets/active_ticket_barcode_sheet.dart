import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:busz/models/home_models.dart';
import 'package:material_symbols_icons/symbols.dart';

class ActiveTicketBarcodeSheet extends StatelessWidget {
  final Ticket ticket;

  const ActiveTicketBarcodeSheet({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              height: 52,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Color(0xFFEAECF0))),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    behavior: HitTestBehavior.opaque,
                    child: const Icon(
                      Symbols.close_rounded,
                      size: 24,
                      color: Color(0xFF101828),
                    ),
                  ),
                ],
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'E-tiketmu di sini',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF101828),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // QR Code
                  Container(
                    width: 190,
                    height: 190,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: QrImageView(
                        data: ticket
                            .id, // Using ticket ID as a stable booking identifier
                        version: QrVersions.auto,
                        size: 190.0,
                        backgroundColor: Colors.white,
                        eyeStyle: const QrEyeStyle(
                          eyeShape: QrEyeShape.square,
                          color: Color(0xFF101828),
                        ),
                        dataModuleStyle: const QrDataModuleStyle(
                          dataModuleShape: QrDataModuleShape.square,
                          color: Color(0xFF101828),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Booking Code
                  const Text(
                    'Kode Booking',
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    ticket.id.toUpperCase(), // Using ID as booking code
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      height: 1.5,
                      color: Color(0xFF101828),
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Helper Text
                  const Text(
                    'Scan the barcode or enter the booking code when getting on the bus.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w400,
                      fontSize: 12,
                      height: 1.5,
                      color: Color(0xFF667085),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
