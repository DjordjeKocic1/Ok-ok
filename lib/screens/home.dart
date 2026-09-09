import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();

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
                    decoration: InputDecoration(
                      label: Text(
                        'Pretraga destinacija',
                        style: TextStyle(fontSize: context.sp(12)),
                      ),
                      prefixIcon: const Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                    ),
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
                    onPressed: () {},
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
          Expanded(
            child: ListView.builder(
              itemCount: serviceData.length,
              itemBuilder: (ctx, index) {
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                    side: BorderSide(color: AppColors.border),
                  ),
                  color: AppColors.background,
                  clipBehavior: Clip.hardEdge,
                  child: InkWell(
                    onTap: () {
                      print(serviceData[index].cost);
                    },
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.person, size: 40),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        serviceData[index].firstName,
                                        style: TextStyle(
                                          fontSize: context.sp(16),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                            size: 15,
                                          ),
                                          const SizedBox(width: 2),
                                          Text('5.0'),
                                          const SizedBox(width: 2),
                                          Text(
                                            '(${serviceData[index].reviewCount.toString()})',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    serviceData[index].destinationStart,
                                    style: TextStyle(
                                      fontSize: context.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Icon(
                                    Icons.arrow_forward_sharp,
                                    size: 15,
                                    color: AppColors.primaryDark,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    serviceData[index].destinationEnd,
                                    style: TextStyle(
                                      fontSize: context.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Icon(Icons.calendar_today, size: 15),
                                  const SizedBox(width: 5),
                                  Text('26.maj - 10:00'),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                children: [
                                  Text(
                                    'Slobodna mesta za paket(e): ${serviceData[index].spotsAvailable}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 20,
                          child: TextButton(
                            onPressed: () {},
                            style: TextButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: const EdgeInsets.symmetric(
                                vertical: 5,
                                horizontal: 10,
                              ),
                              backgroundColor: AppColors.fadeSuccess,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              side: const BorderSide(
                                color: AppColors.successPrimary,
                              ),
                            ),
                            child: Text(
                              'ide sutra',
                              style: TextStyle(
                                color: const Color.fromARGB(255, 49, 131, 52),
                                fontWeight: FontWeight.bold,
                                fontSize: context.sp(12),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 15,
                          right: 20,
                          child: Text(
                            '\$${serviceData[index].cost}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.sp(16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
