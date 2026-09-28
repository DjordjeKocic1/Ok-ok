import 'package:flutter_riverpod/legacy.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/modal/service_item.dart';

class ServiceProviderNotifier extends StateNotifier<List<ServiceItem>> {
  ServiceProviderNotifier() : super([]);

  void filterByDate(String start, String end) {
    final filteredData = serviceData.where((item) {
      final matchesStart = item.destinationStart.city.toLowerCase().contains(
        start.toLowerCase(),
      );

      final matchesEnd = item.destinationEnd.city.toLowerCase().contains(
        end.toLowerCase(),
      );

      return matchesStart && matchesEnd;
    }).toList();

    state = filteredData;
  }

  void clearFilter() {
    state = [];
  }
}

final serviceProvider =
    StateNotifierProvider<ServiceProviderNotifier, List<ServiceItem>>((ref) {
      return ServiceProviderNotifier();
    });
