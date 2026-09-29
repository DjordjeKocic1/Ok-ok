import 'package:ok_ok/modal/service_item.dart';

class RatingHistory {
  const RatingHistory({
    required this.firstName,
    required this.rating,
    required this.comment,
  });

  final String firstName;
  final String rating;
  final String comment;
}

class HistoryDestinations {
  const HistoryDestinations({
    required this.destinationStart,
    required this.destinationEnd,
  });

  final Location destinationStart;
  final Location destinationEnd;
}

class User {
  const User({
    required this.firstName,
    required this.email,
    required this.phone,
    required this.idVerified,
    required this.avatarImage,
    required this.ratingHistory,
    required this.historyDestinations,
    required this.services,
  });

  final String firstName;
  final String email;
  final String phone;
  final bool idVerified;
  final String avatarImage;
  final List<RatingHistory> ratingHistory;
  final List<HistoryDestinations> historyDestinations;
  final List<ServiceItem> services;
}
