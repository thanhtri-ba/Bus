import 'package:flutter/material.dart';
import 'package:busz/models/home_models.dart';
import 'package:busz/services/ticket_service.dart';
import 'active_ticket_card.dart';

class ActiveTicketSection extends StatefulWidget {
  const ActiveTicketSection({super.key});

  @override
  State<ActiveTicketSection> createState() => _ActiveTicketSectionState();
}

class _ActiveTicketSectionState extends State<ActiveTicketSection> {
  Ticket? _activeTicket;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTicket();
  }

  Future<void> _loadTicket() async {
    try {
      final tickets = await TicketService.getMyTickets();
      if (mounted) {
        setState(() {
          _activeTicket = tickets.isNotEmpty ? tickets.first : null;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_activeTicket == null) {
      return const SizedBox(); // Use existing empty state approach if null
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Your Active Ticket',
            style: TextStyle(
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w600,
              fontSize: 16,
              height: 1.5,
              color: Color(0xFF101828),
            ),
          ),
          const SizedBox(height: 16),
          ActiveTicketCard(ticket: _activeTicket!),
        ],
      ),
    );
  }
}
