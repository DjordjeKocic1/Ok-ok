import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/screens/home.dart';
import 'package:ok_ok/utils/responsive.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  List<ServiceItem> _filteredData = [];
  var _isFiltering = false;
  var _destinationStart = '';
  var _destinationEnd = '';

  void _filterData() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      setState(() {
        _filteredData = serviceData.where((item) {
          final matchesStart = item.destinationStart.city
              .toLowerCase()
              .contains(_destinationStart.toLowerCase());

          final matchesEnd = item.destinationEnd.city.toLowerCase().contains(
            _destinationEnd.toLowerCase(),
          );

          return matchesStart && matchesEnd;
        }).toList();
        _isFiltering = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isFiltering) {
      return HomeScreen(
        filteredData: _filteredData,
        onBack: () {
          setState(() {
            _filteredData = [];
            _isFiltering = false;
          });
        },
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pronadji nekog \nko ide tvojim putem',
            style: TextStyle(
              fontSize: context.sp(25),
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Unesi lokaciju odakle i do kuda ti treba usluga.',
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
              fontSize: context.sp(12),
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Od',
                    style: TextStyle(
                      fontSize: context.sp(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.mainColor,
                      label: Text(
                        'Polazna lokacija',
                        style: TextStyle(
                          fontSize: context.sp(14),
                          color: AppColors.textSecondary,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.location_pin,
                        size: context.w(20),
                        color: AppColors.primary,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(15),
                        vertical: context.h(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ne moze da bude prazno';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _destinationStart = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Do',
                    style: TextStyle(
                      fontSize: context.sp(12),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.mainColor,
                      label: Text(
                        'Odredisna lokacija',
                        style: TextStyle(
                          fontSize: context.sp(14),
                          color: AppColors.textSecondary,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.location_pin,
                        size: context.w(20),
                        color: AppColors.primary,
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: context.w(12),
                        vertical: context.h(12),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Ne moze da bude prazno';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _destinationEnd = value!;
                    },
                  ),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: _filterData,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: context.h(10)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search, size: context.w(20)),
                        const SizedBox(width: 10),
                        Text(
                          'Pretrazi',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.sp(14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Skorasnje pretrage',
                style: TextStyle(
                  fontSize: context.sp(16),
                  fontWeight: FontWeight.bold,
                ),
              ),
              InkWell(
                onTap: () {},
                child: Text(
                  'Obrisi sve',
                  style: TextStyle(
                    fontSize: context.sp(14),
                    color: AppColors.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          for (final historyDestination in serviceData[0].historyDestinations)
            Container(
              margin: EdgeInsets.only(top: 5),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 15),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: AppColors.secondaryMainColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.history, color: AppColors.primary),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    historyDestination.destinationStart.city.toString(),
                    style: TextStyle(fontSize: context.sp(14)),
                  ),
                  const SizedBox(width: 5),
                  Icon(
                    Icons.arrow_forward_sharp,
                    size: 15,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    historyDestination.destinationEnd.city.toString(),
                    style: TextStyle(fontSize: context.sp(14)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _filterData,
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.h(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: context.w(20)),
                const SizedBox(width: 10),
                Text(
                  'Dodaj uslugu',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.sp(14),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
