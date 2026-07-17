import 'package:flutter/material.dart';

class UserProfile {
  final String name;
  final String dob;

  UserProfile({required this.name, required this.dob});

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      name: json['full_name'] as String? ?? 'Người Dùng',
      dob: json['dob'] as String? ?? '',
    );
  }
}

class Wallet {
  final String balanceStr;

  Wallet({required this.balanceStr});

  factory Wallet.fromJson(Map<String, dynamic> json) {
    final bal = json['balance'] as int? ?? 0;
    return Wallet(balanceStr: '$bal ₫');
  }
}

class Loyalty {
  final int points;
  final String tierName;

  Loyalty({required this.points, required this.tierName});

  factory Loyalty.fromJson(Map<String, dynamic> json) {
    return Loyalty(
      points: json['points'] as int? ?? 0,
      tierName:
          json['tierName'] as String? ??
          json['tier_name'] as String? ??
          'Thành Viên Mới',
    );
  }
}

class City {
  final String id;
  final String name;
  final String? image;
  final String? subtitle;

  City({required this.id, required this.name, this.image, this.subtitle});

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      id: json['id'] as String,
      name: json['name'] as String,
      image: json['image'] as String?,
      subtitle: json['subtitle'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'image': image, 'subtitle': subtitle};
  }
}

class Station {
  final String id;
  final String name;
  final String cityId;
  final bool isPopular;

  Station({
    required this.id,
    required this.name,
    required this.cityId,
    this.isPopular = false,
  });

  factory Station.fromJson(Map<String, dynamic> json) {
    return Station(
      id: json['id'] as String,
      name: json['name'] as String,
      cityId: json['city_id'] as String,
      isPopular: json['is_popular'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'city_id': cityId, 'is_popular': isPopular};
  }
}

class Trip {
  final String id;
  final String busAgent;
  final String busAgentLogo;
  final String busClass;
  final String departureTime;
  final String departureStation;
  final String arrivalTime;
  final String arrivalStation;
  final String duration;
  final int pointsEarned;
  final int price;

  Trip({
    required this.id,
    required this.busAgent,
    required this.busAgentLogo,
    required this.busClass,
    required this.departureTime,
    required this.departureStation,
    required this.arrivalTime,
    required this.arrivalStation,
    required this.duration,
    required this.pointsEarned,
    required this.price,
  });

  factory Trip.fromJson(Map<String, dynamic> json) {
    // Handling PostgREST structure for TripSchedule -> Trip -> Route / BusAgent
    final trip = json['Trip'] ?? json['trips'] ?? json['trip'] ?? {};
    final agent = trip['bus_agents'] ?? trip['busAgent'] ?? {};
    final route = trip['Route'] ?? trip['route'] ?? {};
    final depCity = route['departureCity']?['name'] ?? 'Unknown';
    final arrCity = route['arrivalCity']?['name'] ?? 'Unknown';

    // Checkpoints for stations (Fallback to city if no checkpoints)
    final checkpoints =
        (json['checkpoints'] ?? json['Checkpoint'] as List?) ?? [];
    String depStation = depCity;
    String arrStation = arrCity;

    for (var cp in checkpoints) {
      if (cp['type'] == 'DEPARTURE')
        depStation =
            cp['Station']?['name'] ?? cp['station']?['name'] ?? depStation;
      if (cp['type'] == 'ARRIVAL')
        arrStation =
            cp['Station']?['name'] ?? cp['station']?['name'] ?? arrStation;
    }

    // Prices
    final prices = (json['TripPrice'] ?? json['prices'] as List?) ?? [];
    int price = 0;
    if (prices.isNotEmpty) {
      price = (prices[0]['price'] as num?)?.toInt() ?? 0;
    }

    return Trip(
      id: json['id'] as String, // TripSchedule ID
      busAgent: agent['name'] as String? ?? 'Unknown',
      busAgentLogo: agent['logo'] as String? ?? '', // updated logo column
      busClass: trip['busClass'] as String? ?? 'EXECUTIVE',
      departureTime: json['departureTime'] as String? ?? '',
      departureStation: depStation,
      arrivalTime: json['arrivalTime'] as String? ?? '',
      arrivalStation: arrStation,
      duration: '${json['durationMins'] ?? 0} mins',
      pointsEarned: ((price) * 0.01).toInt(), // 1% points
      price: price,
    );
  }
}

class SearchRequest {
  final String departureCity;
  final String arrivalCity;
  final DateTime date;
  final bool isRoundTrip;

  SearchRequest({
    required this.departureCity,
    required this.arrivalCity,
    required this.date,
    this.isRoundTrip = false,
  });
}

class Promo {
  final String id;
  final String title;
  final String subtitle;
  final String logoPath;
  final int discountAmount;

  Promo({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.logoPath,
    this.discountAmount = 0,
  });

  factory Promo.fromJson(Map<String, dynamic> json) {
    return Promo(
      id: json['code'] as String? ?? '',
      title: json['title'] as String? ?? '',
      subtitle: json['subtitle'] as String? ?? '',
      logoPath: json['logoPath'] as String? ?? '',
      discountAmount: (json['maxDiscount'] as num?)?.toInt() ?? 0,
    );
  }
}

enum TicketStatus { active, waitingPayment, canceled, paymentExpired }

class JourneySegment {
  final String iconType; // 'walking', 'bus', 'destination'
  final String title;
  final String? subtitle;
  final String? durationBadge;

  JourneySegment({
    required this.iconType,
    required this.title,
    this.subtitle,
    this.durationBadge,
  });
}

class Ticket {
  final String id;
  final String bookingCode;
  final String busAgent;
  final String busClass;
  final TicketStatus status;
  final String type;

  final DateTime date;
  final String departureTime;
  final String departureStation;
  final String arrivalTime;
  final String arrivalStation;
  final String duration;
  final String boardingTime;

  final DateTime? paymentExpiresAt;
  final int ticketPrice;
  final int protectionPrice;
  final int convenienceFee;

  final String passengerName;
  final String passengerEmail;
  final String passengerPhone;

  final List<JourneySegment>? journeySegments;

  Ticket({
    required this.id,
    required this.bookingCode,
    required this.busAgent,
    required this.busClass,
    required this.status,
    required this.type,
    required this.date,
    required this.departureTime,
    required this.departureStation,
    required this.arrivalTime,
    required this.arrivalStation,
    required this.duration,
    required this.boardingTime,
    this.paymentExpiresAt,
    required this.ticketPrice,
    this.protectionPrice = 0,
    this.convenienceFee = 0,
    required this.passengerName,
    required this.passengerEmail,
    required this.passengerPhone,
    this.journeySegments,
  });

  int get totalAmount => ticketPrice + protectionPrice + convenienceFee;

  factory Ticket.fromJson(Map<String, dynamic> json) {
    TicketStatus statusEnum = TicketStatus.active;
    final statusStr = json['status'] as String?;
    if (statusStr != null) {
      statusEnum = TicketStatus.values.firstWhere(
        (e) => e.toString().split('.').last == statusStr,
        orElse: () => TicketStatus.active,
      );
    }

    final booking = json['Booking'] ?? {};
    final tripSched = booking['TripSchedule'] ?? {};
    final trip = tripSched['Trip'] ?? tripSched['trips'] ?? {};
    final agent = trip['busAgent'] ?? trip['bus_agents'] ?? {};
    final route = trip['Route'] ?? {};
    final depCity = route['departureCity']?['name'] ?? 'Unknown';
    final arrCity = route['arrivalCity']?['name'] ?? 'Unknown';
    final passenger = json['Passenger'] ?? {};

    return Ticket(
      id: json['id'] as String,
      bookingCode:
          booking['id']?.toString().substring(0, 8).toUpperCase() ?? 'UNKNOWN',
      busAgent: agent['name'] as String? ?? 'Unknown',
      busClass: trip['busClass'] as String? ?? 'Unknown',
      status: statusEnum,
      type: 'E-Ticket',
      date: booking['createdAt'] != null
          ? DateTime.parse(booking['createdAt'])
          : DateTime.now(),
      departureTime: tripSched['departureTime'] as String? ?? '',
      departureStation: depCity,
      arrivalTime: tripSched['arrivalTime'] as String? ?? '',
      arrivalStation: arrCity,
      duration: '${tripSched['durationMins'] ?? 0} mins',
      boardingTime: tripSched['departureTime'] as String? ?? '',
      paymentExpiresAt: null,
      ticketPrice: (booking['totalAmount'] as num?)?.toInt() ?? 0,
      protectionPrice: 0,
      convenienceFee: 0,
      passengerName: passenger['name'] as String? ?? '',
      passengerEmail: '', // Not in schema anymore
      passengerPhone: '', // Not in schema anymore
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'status': status.toString().split('.').last,
      'Booking': {
        'id': bookingCode, // using bookingCode as id mapping for simplicity
        'createdAt': date.toIso8601String(),
        'totalAmount': ticketPrice,
        'TripSchedule': {
          'departureTime': departureTime,
          'arrivalTime': arrivalTime,
          'durationMins': int.tryParse(duration.split(' ')[0]) ?? 0,
          'Trip': {
            'busClass': busClass,
            'busAgent': {'name': busAgent},
            'Route': {
              'departureCity': {'name': departureStation},
              'arrivalCity': {'name': arrivalStation},
            },
          },
        },
      },
      'Passenger': {'name': passengerName},
    };
  }
}

class SearchHistory {
  final String id;
  final String route;
  final String date;
  final String passengerInfo;

  SearchHistory({
    required this.id,
    required this.route,
    required this.date,
    required this.passengerInfo,
  });

  factory SearchHistory.fromJson(Map<String, dynamic> json) {
    return SearchHistory(
      id: json['id'] as String,
      route: json['route_name'] as String? ?? '',
      date: json['search_date'] as String? ?? '',
      passengerInfo: json['passenger_info'] as String? ?? '',
    );
  }
}

class CalendarPrice {
  final DateTime date;
  final String priceStr;
  final Color priceColor;

  CalendarPrice({
    required this.date,
    required this.priceStr,
    required this.priceColor,
  });
}

class BusAgent {
  final String id;
  final String name;

  BusAgent({required this.id, required this.name});

  factory BusAgent.fromJson(Map<String, dynamic> json) {
    return BusAgent(id: json['id'] as String, name: json['name'] as String);
  }
}
