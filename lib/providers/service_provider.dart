import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/api/services_api.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/modal/service_item.dart';

class ServiceProviderNotifier extends AsyncNotifier<List<ServiceItem>> {
  @override
  Future<List<ServiceItem>> build() => ServicesApi.getMyServices();

  Future<void> create({
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
    final createdService = await ServicesApi.createService(
      transportMode: transportMode,
      destinationStart: destinationStart,
      destinationEnd: destinationEnd,
      departureTime: departureTime,
      tripNote: tripNote,
      spotsAvailable: spotsAvailable,
      cost: cost,
      maxWeight: maxWeight,
      restrictedItems: restrictedItems,
    );
    final currentState = state.value ?? const <ServiceItem>[];
    state = AsyncData([...currentState, createdService]);
  }
}

final serviceProvider =
    AsyncNotifierProvider<ServiceProviderNotifier, List<ServiceItem>>(
      ServiceProviderNotifier.new,
    );
