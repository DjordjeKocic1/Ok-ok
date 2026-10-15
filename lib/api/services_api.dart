import 'package:ok_ok/api/api_client.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/modal/service_item.dart';

class ServicesApi {
  static Future<List<ServiceItem>> getServicesByLocation(
    String start,
    String end,
  ) async {
    final data = await ApiClient.get(
      '/services/${Uri.encodeComponent(start)}/${Uri.encodeComponent(end)}',
    );
    return (data['services'] as List)
        .map((e) => ServiceItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<List<ServiceItem>> getMyServices() async {
    final data = await ApiClient.get('/services');
    return (data['services'] as List)
        .map((e) => ServiceItem.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  static Future<ServiceItem> createService({
    required TransportType transportMode,
    required Location destinationStart,
    required Location destinationEnd,
    required String departureTime,
    required String tripNote,
    required int spotsAvailable,
    required int cost,
    required int maxWeight,
    List<String>? restrictedItems,
  }) async {
    final data = await ApiClient.post('/services/create', {
      "transportMode": transportMode.name,
      "destinationStart": destinationStart,
      "destinationEnd": destinationEnd,
      "departureTime": departureTime,
      "tripNote": tripNote,
      "spotsAvailable": spotsAvailable,
      "cost": cost,
      "maxWeight": maxWeight,
      "restrictedItems": restrictedItems,
    });

    return ServiceItem.fromJson(data['service'] as Map<String, dynamic>);
  }
}
