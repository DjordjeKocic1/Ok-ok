import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';

class ServicesList extends StatelessWidget {
  const ServicesList({super.key, required this.filteredData});

  final List<ServiceItem> filteredData;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: filteredData.length,
        itemBuilder: (ctx, index) {
          final dateInfo = getDateTime(filteredData[index].departureTime);
          var departureDate = dateInfo.dayMonth;
          var departureTime = dateInfo.time;
          var isTomorrow = dateInfo.isTomorrow;
          var badgeText = isTomorrow ? 'ide sutra' : 'ide $departureDate';
          var ratingText = getAverageRating(
            filteredData[index].ratingHistory,
          ).toStringAsFixed(1);

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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  filteredData[index].firstName,
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
                                    Text(ratingText),
                                    const SizedBox(width: 2),
                                    Text(
                                      '(${filteredData[index].ratingHistory.length.toString()})',
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
                              filteredData[index].destinationStart,
                              style: TextStyle(
                                fontSize: context.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward_sharp,
                              size: 15,
                              color: AppColors.primary,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              filteredData[index].destinationEnd,
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
                            Text('$departureDate - $departureTime'),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          children: [
                            Text(
                              'Slobodna mesta za paket(e): ${filteredData[index].spotsAvailable}',
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
                        side: const BorderSide(color: AppColors.successPrimary),
                      ),
                      child: Text(
                        badgeText,
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
                      '\$${filteredData[index].cost}',
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
    );
  }
}
