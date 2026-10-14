import 'package:ok_ok/modal/user.dart';

class Review {
  const Review({
    required String id,
    required this.fromUser,
    required this.toUser,
    required this.rating,
    required this.comment,
  }) : _id = id;

  final String _id;
  String get id => _id;

  final User? fromUser;
  final String toUser;
  final double rating;
  final String comment;

  factory Review.fromJson(Map<String, dynamic> json) {
    final from = json['fromUser'];
    final to = json['toUser'];

    return Review(
      id: json['_id'] as String? ?? '',
      fromUser: from is Map<String, dynamic> ? User.fromJson(from) : null,
      toUser: to is Map<String, dynamic>
          ? (to['_id'] as String? ?? '')
          : (to as String? ?? ''),
      rating: (json['rating'] as num? ?? 0).toDouble(),
      comment: json['comment'] as String? ?? '',
    );
  }
}
