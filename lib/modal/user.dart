import 'package:ok_ok/modal/review.dart';
import 'package:ok_ok/modal/service_item.dart';

class SearchedDestinations {
  const SearchedDestinations({
    required this.destinationStart,
    required this.destinationEnd,
  });

  final Location destinationStart;
  final Location destinationEnd;

  factory SearchedDestinations.fromJson(Map<String, dynamic> json) {
    return SearchedDestinations(
      destinationStart: Location.fromJson(json['destinationStart']),
      destinationEnd: Location.fromJson(json['destinationEnd']),
    );
  }

  Map<String, dynamic> toJson() => {
    'destinationStart': destinationStart.toJson(),
    'destinationEnd': destinationEnd.toJson(),
  };
}

class User {
  const User({
    required String id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.idVerified,
    required this.searchedDestinations,
    required this.ratingCount,
    required this.ratingAverage,
    required this.reviews,
  }) : _id = id;

  final String _id;

  String get id => _id;

  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final bool idVerified;
  final List<SearchedDestinations> searchedDestinations;
  final int ratingCount;
  final double ratingAverage;
  final List<Review> reviews;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] as String,
      firstName: json['firstName'] as String? ?? '',
      lastName: json['lastName'] as String? ?? '',
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      idVerified: json['idVerified'] as bool? ?? false,
      searchedDestinations: (json['searchedDestinations'] as List? ?? [])
          .map((e) => SearchedDestinations.fromJson(e as Map<String, dynamic>))
          .toList(),
      ratingCount: (json['ratingCount'] as num? ?? 0).toInt(),
      ratingAverage: (json['ratingAverage'] as num? ?? 0).toDouble(),
      reviews: (json['reviews'] as List? ?? [])
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
