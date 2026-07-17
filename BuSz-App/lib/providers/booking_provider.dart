import 'package:flutter/foundation.dart';

/// BusZ — Booking State Provider
///
/// Central state for the entire booking flow:
/// Home Search → Search Results → Trip Detail → Seat Selection
/// → Passenger Info → Booking Summary → Payment → Result
class PassengerData {
  final String name;
  final String phone;
  final String idNumber;
  final String email;

  const PassengerData({
    required this.name,
    required this.phone,
    required this.idNumber,
    this.email = '',
  });
}

class SelectedTrip {
  final String id;
  final String company;
  final String busType;
  final String departureTime;
  final String arrivalTime;
  final String duration;
  final String departureStation;
  final String arrivalStation;
  final int basePricePerSeat; // in VND

  const SelectedTrip({
    required this.id,
    required this.company,
    required this.busType,
    required this.departureTime,
    required this.arrivalTime,
    required this.duration,
    required this.departureStation,
    required this.arrivalStation,
    required this.basePricePerSeat,
  });
}

class BookingProvider extends ChangeNotifier {
  // ─── Search Params ─────────────────────────────────────────────
  String _departure = '';
  String _destination = '';
  String _travelDate = '';
  int _passengerCount = 1;

  // ─── Trip Selection ─────────────────────────────────────────────
  SelectedTrip? _selectedTrip;

  // ─── Seat Selection ─────────────────────────────────────────────
  List<String> _selectedSeats = [];
  Map<String, int> _seatPrices = {}; // Map seat label to its price
  int _seatPrice = 0; // total seat price

  // ─── Passenger Info & Dropoff ───────────────────────────────────
  String _contactName = '';
  String _contactPhone = '';
  String _contactEmail = '';
  List<PassengerData> _passengers = [];
  String _customDropoffAddress = '';

  // ─── Promo / Discount ───────────────────────────────────────────
  String _promoCode = '';
  int _discountAmount = 0;

  // ─── Service Fee ────────────────────────────────────────────────
  static const int serviceFee = 10000;

  // ─── Getters ────────────────────────────────────────────────────
  String get departure => _departure;
  String get destination => _destination;
  String get travelDate => _travelDate;
  int get passengerCount => _passengerCount;
  SelectedTrip? get selectedTrip => _selectedTrip;
  List<String> get selectedSeats => List.unmodifiable(_selectedSeats);
  int get seatCount => _selectedSeats.length;
  String get contactName => _contactName;
  String get contactPhone => _contactPhone;
  String get contactEmail => _contactEmail;
  List<PassengerData> get passengers => List.unmodifiable(_passengers);
  String get customDropoffAddress => _customDropoffAddress;
  String get promoCode => _promoCode;
  int get discountAmount => _discountAmount;

  int get ticketTotal => _seatPrice;
  int get grandTotal => ticketTotal + serviceFee - _discountAmount;

  // ─── Actions ────────────────────────────────────────────────────

  /// Set search parameters from the home search card
  void setSearch({
    required String departure,
    required String destination,
    required String date,
    int passengerCount = 1,
  }) {
    _departure = departure;
    _destination = destination;
    _travelDate = date;
    _passengerCount = passengerCount;
    notifyListeners();
  }

  /// Set the selected trip when user taps on a trip card
  void selectTrip(SelectedTrip trip) {
    _selectedTrip = trip;
    // Reset downstream state
    _selectedSeats = [];
    _seatPrices = {};
    _seatPrice = 0;
    _passengers = [];
    _discountAmount = 0;
    _promoCode = '';
    notifyListeners();
  }

  /// Toggle a seat: add if not selected, remove if already selected
  void toggleSeat(String seatLabel, {int? price}) {
    if (_selectedSeats.contains(seatLabel)) {
      _selectedSeats.remove(seatLabel);
      _seatPrices.remove(seatLabel);
    } else {
      _selectedSeats.add(seatLabel);
      if (price != null) {
        _seatPrices[seatLabel] = price;
      }
    }
    _recalculateSeatPrice();
    notifyListeners();
  }

  /// Clear seats before navigating from SeatSelection to prevent dupes
  void clearSeats() {
    _selectedSeats.clear();
    _seatPrices.clear();
    _seatPrice = 0;
    notifyListeners();
  }

  void _recalculateSeatPrice() {
    final basePrice = _selectedTrip?.basePricePerSeat ?? 0;
    _seatPrice = _selectedSeats.fold(
      0,
      (sum, seatLabel) => sum + (_seatPrices[seatLabel] ?? basePrice),
    );
  }

  /// Save contact and passenger info
  void setContactInfo({
    required String name,
    required String phone,
    required String email,
  }) {
    _contactName = name;
    _contactPhone = phone;
    _contactEmail = email;
    notifyListeners();
  }

  void setPassengers(List<PassengerData> passengers) {
    _passengers = List.from(passengers);
    notifyListeners();
  }

  void setCustomDropoffAddress(String address) {
    _customDropoffAddress = address;
    notifyListeners();
  }

  /// Apply promo code (simplified mock logic)
  void applyPromo(String code) {
    _promoCode = code;
    if (code.toUpperCase() == 'BUSZ10') {
      _discountAmount = 50000;
    } else if (code.toUpperCase() == 'SALE20') {
      _discountAmount = (_ticketTotal * 0.2).round();
    } else {
      _discountAmount = 0;
    }
    notifyListeners();
  }

  int get _ticketTotal => _seatPrice;

  /// Reset the entire booking state after completion or cancellation
  void resetBooking() {
    _selectedTrip = null;
    _selectedSeats = [];
    _seatPrices = {};
    _seatPrice = 0;
    _passengers = [];
    _contactName = '';
    _contactPhone = '';
    _contactEmail = '';
    _customDropoffAddress = '';
    _promoCode = '';
    _discountAmount = 0;
    notifyListeners();
  }

  /// Format VND amount for display
  static String formatVND(int amount) {
    final str = amount.toString();
    final buffer = StringBuffer();
    for (int i = 0; i < str.length; i++) {
      if ((str.length - i) % 3 == 0 && i != 0) buffer.write('.');
      buffer.write(str[i]);
    }
    return '${buffer.toString()}đ';
  }
}
