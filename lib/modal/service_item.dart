import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/modal/user.dart';

class Location {
  const Location({required this.country, required this.city});

  final String country;
  final String city;

  factory Location.fromJson(Map<String, dynamic> json) {
    final map = Map<String, dynamic>.from(json);

    return Location(
      country: map['country'] as String? ?? '',
      city: map['city'] as String? ?? '',
    );
  }

  Map<String, dynamic> toJson() => {'country': country, 'city': city};
}

class ServiceItem {
  const ServiceItem({
    required String id,
    required this.status,
    required this.tripNote,
    required this.ratingHistory,
    required this.destinationStart,
    required this.destinationEnd,
    required this.departureTime,
    required this.cost,
    required this.maxWeight,
    required this.restrictedItems,
    required this.spotsAvailable,
    required this.transportMode,
    this.user,
  }) : _id = id;

  final String _id;

  String get id => _id;

  final ServiceStatus status;
  final String tripNote;
  final List<String> ratingHistory;
  final Location destinationStart;
  final Location destinationEnd;
  final String departureTime;
  final int cost;
  final int maxWeight;
  final List<String> restrictedItems;
  final int spotsAvailable;
  final String transportMode;
  final User? user;

  factory ServiceItem.fromJson(Map<String, dynamic> json) {
    return ServiceItem(
      id: json['_id'] as String? ?? '',
      status: ServiceStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => ServiceStatus.values.first,
      ),
      tripNote: json['tripNote'] as String? ?? '',
      ratingHistory: List<String>.from(json['ratingHistory'] ?? const []),
      destinationStart: Location.fromJson(
        json['destinationStart'] as Map<String, dynamic>,
      ),
      destinationEnd: Location.fromJson(
        json['destinationEnd'] as Map<String, dynamic>,
      ),
      departureTime: json['departureTime'] as String? ?? '',
      cost: (json['cost'] as num?)?.toInt() ?? 0,
      maxWeight: (json['maxWeight'] as num?)?.toInt() ?? 0,
      restrictedItems: List<String>.from(json['restrictedItems'] ?? const []),
      spotsAvailable: (json['spotsAvailable'] as num?)?.toInt() ?? 0,
      transportMode: json['transportMode'] as String? ?? '',
      user: json['user'] is Map<String, dynamic>
          ? User.fromJson(json['user'] as Map<String, dynamic>)
          : null,
    );
  }
}
