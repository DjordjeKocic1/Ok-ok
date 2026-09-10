class ServiceItem {
  const ServiceItem({
    required this.firstName,
    required this.avatarImage,
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
  });

  final String firstName;
  final String avatarImage;
  final String tripNote;
  final List<String> ratingHistory;
  final String destinationStart;
  final String destinationEnd;
  final String departureTime;
  final int cost;
  final int maxWeight;
  final List<String> restrictedItems;
  final int spotsAvailable;
  final String transportMode;
}
