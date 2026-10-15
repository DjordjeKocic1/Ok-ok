import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/modal/user.dart';

class Request {
  const Request({
    required String id,
    required this.fromUser,
    required this.service,
    required this.transportDescription,
    required this.packageWeight,
    required this.status,
    required this.rated,
    this.specialRequest,
    this.specialRequestCost,
  }) : _id = id;

  final String _id;

  String get id => _id;

  final User? fromUser;
  final String service;
  final String transportDescription;
  final int packageWeight;
  final RequestStatus status;
  final bool? rated;
  final String? specialRequest;
  final int? specialRequestCost;

  factory Request.fromJson(Map<String, dynamic> json) {
    return Request(
      id: json['_id'] as String? ?? '',
      fromUser: json['fromUser'] is Map<String, dynamic>
          ? User.fromJson(json['fromUser'])
          : null,
      rated: json['rated'] as bool? ?? false,
      service: json['service'] as String? ?? '',
      status: RequestStatus.values.firstWhere(
        (s) => s.name == json['status'],
        orElse: () => RequestStatus.values.first,
      ),
      transportDescription: json['transportDescription'] as String? ?? '',
      packageWeight: (json['packageWeight'] as num?)?.toInt() ?? 0,
    );
  }
}
