import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/providers/service_provider.dart';
import 'package:ok_ok/screens/add_service.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/widgets/services_list.dart';

class SearchScreen extends ConsumerStatefulWidget {
  const SearchScreen({super.key});

  @override
  ConsumerState<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends ConsumerState<SearchScreen> {
  final _formKey = GlobalKey<FormState>();
  var _destinationStart = '';
  var _destinationEnd = '';

  void _filterData() {
    final lang = ref.read(languageProvider.notifier);
    final userNotifier = ref.read(serviceProvider.notifier);
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      userNotifier.filterByDate(_destinationStart, _destinationEnd);

      final userData = ref.read(serviceProvider);

      if (userData.isEmpty) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            content: Text(
              lang.translate('serviceDialog'),
              style: TextStyle(fontSize: ctx.sp(14)),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text("OK"),
              ),
            ],
          ),
        );
      }
    }
  }

  void _goToAddService(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddServiceScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);
    final service = ref.watch(serviceProvider);
    ref.watch(languageProvider);

    if (service.isNotEmpty) {
      return ServicesList(
        destinationStart: _destinationStart,
        destinationEnd: _destinationEnd,
        onBack: () {
          setState(() {
            ref.read(serviceProvider.notifier).clearFilter();
          });
        },
      );
    }
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            lang.translate('foundSomeOne'),
            style: TextStyle(
              fontSize: context.sp(25),
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            lang.translate('enterLocationForService'),
            textWidthBasis: TextWidthBasis.longestLine,
            style: TextStyle(
              fontSize: context.sp(14),
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
                    lang.translate('from'),
                    style: TextStyle(
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.mainColor,
                      label: Text(
                        lang.translate('inputStartLocation'),
                        style: TextStyle(
                          fontSize: context.sp(14),
                          color: AppColors.textSecondary,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.place_outlined,
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
                        return lang.translate('inputNullError');
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _destinationStart = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  Text(
                    lang.translate("to"),
                    style: TextStyle(
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  TextFormField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: AppColors.mainColor,
                      label: Text(
                        lang.translate('inputEndLocation'),
                        style: TextStyle(
                          fontSize: context.sp(14),
                          color: AppColors.textSecondary,
                        ),
                      ),
                      prefixIcon: Icon(
                        Icons.gps_fixed_outlined,
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
                        return lang.translate('inputNullError');
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
                          lang.translate('searchButton'),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.sp(15),
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  lang.translate('recentSearch'),
                  style: TextStyle(
                    fontSize: context.sp(15),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Text(
                    lang.translate('removeAll'),
                    style: TextStyle(
                      fontSize: context.sp(15),
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
          for (final historyDestination in userFakeData[0].historyDestinations)
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
            onPressed: () {
              _goToAddService(context);
            },
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.h(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add, size: context.w(20)),
                const SizedBox(width: 10),
                Text(
                  lang.translate('addService'),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.sp(15),
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
