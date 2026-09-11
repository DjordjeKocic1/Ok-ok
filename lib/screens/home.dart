import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/modals/filter_modal.dart';
import 'package:ok_ok/widgets/services_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _hasActiveFilters = false;
  final TextEditingController _searchController = TextEditingController();
  List<ServiceItem> filteredServices = [];

  @override
  void initState() {
    super.initState();
    filteredServices = serviceData;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _quickfilterByDestinationEnd(String query) {
    setState(() {
      if (query.isEmpty) {
        _hasActiveFilters = false;
        filteredServices = serviceData;
      } else {
        _hasActiveFilters = true;
        filteredServices = serviceData
            .where(
              (item) => item.destinationEnd.toLowerCase().contains(
                query.toLowerCase(),
              ),
            )
            .toList();
      }
    });
  }

  Future<void> _showFilters() async {
    final result = await showModalBottomSheet<Map<String, dynamic>>(
      context: context,
      isScrollControlled: true,
      builder: (ctx) {
        return const FilterModal();
      },
    );

    final String destinationStart =
        (result?['destinationStart'] as String?) ?? '';
    final String destinationEnd = (result?['destinationEnd'] as String?) ?? '';
    final String maxCostText = (result?['maxCost'] as String?) ?? '';
    final int? maxCost = int.tryParse(maxCostText);
    final double? minRating = result?['minRating'] as double?;

    if (destinationStart.isEmpty &&
        destinationEnd.isEmpty &&
        maxCostText.isEmpty &&
        minRating == null) {
      return;
    }

    setState(() {
      _hasActiveFilters = true;
      filteredServices = serviceData.where((item) {
        final matchesStart =
            destinationStart.isEmpty ||
            item.destinationStart.toLowerCase().contains(
              destinationStart.toLowerCase(),
            );

        final matchesEnd =
            destinationEnd.isEmpty ||
            item.destinationEnd.toLowerCase().contains(
              destinationEnd.toLowerCase(),
            );

        final findAverageRating = getAverageRating(item.ratingHistory);

        final matchesRating =
            minRating == null || minRating <= findAverageRating;

        final matchesCost = maxCost == null || item.cost <= maxCost;

        return matchesStart && matchesEnd && matchesCost && matchesRating;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Image.asset('assets/images/logo.png', width: 100),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Dostupne usluge',
            style: TextStyle(
              fontSize: context.sp(18),
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Pronadji nekog ko ide tvojim putem',
            style: TextStyle(
              fontSize: context.sp(14),
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    label: Text(
                      'Pretraga destinacija',
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
                    prefixIcon: const Icon(Icons.search),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 10,
                    ),
                  ),
                  onChanged: _quickfilterByDestinationEnd,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                flex: 1,
                child: TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  ),
                  onPressed: _showFilters,
                  child: const Icon(
                    Icons.display_settings,
                    color: AppColors.primaryDark,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          if (_hasActiveFilters)
            Padding(
              padding: const EdgeInsets.only(top: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _hasActiveFilters = false;
                    filteredServices = serviceData;
                  });
                },
                child: Row(
                  children: [
                    Icon(Icons.close, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      'Ukloni filtere',
                      style: TextStyle(fontSize: context.sp(12)),
                    ),
                  ],
                ),
              ),
            ),
          const SizedBox(height: 20),
          Expanded(
            child: filteredServices.isEmpty
                ? const Center(child: Text('Nema dostupnih destinacija'))
                : ServicesList(filteredData: filteredServices),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add_circle_outline, size: 30),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dodaj uslugu',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: context.sp(16),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'Pruzi uslugu drugima',
                      style: TextStyle(fontSize: context.sp(12)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
