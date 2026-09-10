import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/services_list.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
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

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredServices = serviceData;
      } else {
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
          Form(
            key: _formKey,
            child: Row(
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
                    onChanged: _filterServices,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  flex: 1,
                  child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: AppColors.mainColor,
                      padding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        builder: (ctx) {
                          return Padding(
                            padding: EdgeInsets.all(20),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: const [Text('Filter services')],
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.display_settings,
                      color: AppColors.primaryDark,
                      size: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          ServicesList(filteredData: filteredServices),
        ],
      ),
    );
  }
}
