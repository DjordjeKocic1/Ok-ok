import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/services_list.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
    required this.filteredData,
    required this.onBack,
  });

  final List<ServiceItem> filteredData;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: InkWell(
            onTap: onBack,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.arrow_back,
                  size: context.w(18),
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(
                  'Nazad na pretragu',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: context.sp(14),
                  ),
                ),
              ],
            ),
          ),
        ),
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
        const SizedBox(height: 10),
        Expanded(
          child: filteredData.isEmpty
              ? const Center(child: Text('Nema dostupnih destinacija'))
              : ServicesList(filteredData: filteredData),
        ),
      ],
    );
  }
}
