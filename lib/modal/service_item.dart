class Location {
  const Location({required this.country, required this.city});

  final String country;
  final String city;
}

class HistoryDestinations {
  const HistoryDestinations({
    required this.destinationStart,
    required this.destinationEnd,
  });

  final Location destinationStart;
  final Location destinationEnd;
}

class ServiceItem {
  const ServiceItem({
    required this.firstName,
    required this.email,
    required this.avatarImage,
    required this.tripNote,
    required this.ratingHistory,
    required this.destinationStart,
    required this.destinationEnd,
    required this.departureTime,
    required this.historyDestinations,
    required this.cost,
    required this.maxWeight,
    required this.restrictedItems,
    required this.spotsAvailable,
    required this.transportMode,
  });

  final String firstName;
  final String email;
  final String avatarImage;
  final String tripNote;
  final List<String> ratingHistory;
  final Location destinationStart;
  final Location destinationEnd;
  final List<HistoryDestinations> historyDestinations;
  final String departureTime;
  final int cost;
  final int maxWeight;
  final List<String> restrictedItems;
  final int spotsAvailable;
  final String transportMode;
}
