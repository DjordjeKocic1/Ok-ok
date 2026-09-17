import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.serviceItem});

  final ServiceItem serviceItem;

  @override
  Widget build(BuildContext context) {
    final dateInfo = getDateTime(serviceItem.departureTime);
    var departureDate = dateInfo.dayMonth;
    var departureTime = dateInfo.time;
    var departureYear = dateInfo.year;
    var ratingText = getAverageRating(
      serviceItem.ratingHistory,
    ).toStringAsFixed(1);

    Widget restrictedContent(String restrictedItem) {
      var iconColor = AppColors.primary;
      var iconSize = context.w(25);
      return Column(
        children: [
          if (restrictedItem == 'Pets')
            Icon(Icons.pets_outlined, color: iconColor, size: iconSize),
          if (restrictedItem == 'Breaking Glass')
            Icon(Icons.wine_bar_outlined, color: iconColor, size: iconSize),
          if (restrictedItem == 'Flammable materials')
            Icon(Icons.eco_outlined, color: iconColor, size: iconSize),
          if (restrictedItem == 'Alcohol')
            Icon(Icons.liquor_outlined, color: iconColor, size: iconSize),
          Text(
            restrictedItem.replaceAll(' ', '\n'),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.sp(10)),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Image.asset('assets/images/logo.png', width: context.w(100)),
      ),
      body: ScreenPadding(
        extra: const EdgeInsets.only(bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              serviceItem.firstName,
              style: TextStyle(
                fontSize: context.sp(16),
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(Icons.star, color: Colors.amber, size: 20),
                const SizedBox(width: 4),
                Text(ratingText, style: TextStyle(fontSize: context.sp(14))),
                const SizedBox(width: 3),
                Text(
                  '(${serviceItem.ratingHistory.length.toString()})',
                  style: TextStyle(fontSize: context.sp(14)),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Text(
                  serviceItem.destinationStart.city,
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
                Flexible(
                  child: Text(
                    serviceItem.destinationEnd.city,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: context.sp(16),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.calendar_today, size: context.w(20)),
                const SizedBox(width: 5),
                Text(
                  '$departureDate $departureYear',
                  style: TextStyle(fontSize: context.sp(14)),
                ),
                const SizedBox(width: 20),
                Icon(
                  Icons.timer_outlined,
                  size: context.w(20),
                  color: AppColors.primary,
                ),
                const SizedBox(width: 5),
                Text(departureTime, style: TextStyle(fontSize: context.sp(14))),
              ],
            ),
            const SizedBox(height: 10),
            Divider(color: Colors.grey.shade300, thickness: 1),
            const SizedBox(height: 10),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Detalji",
                        style: TextStyle(
                          fontSize: context.sp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        serviceItem.tripNote,
                        style: TextStyle(fontSize: context.sp(14)),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          Icon(Icons.card_travel, size: context.w(20)),
                          const SizedBox(width: 10),
                          Text(
                            'Slobodna mesta za paket(e): ${serviceItem.spotsAvailable}',
                            style: TextStyle(fontSize: context.sp(14)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.scale_outlined, size: context.w(20)),
                          const SizedBox(width: 10),
                          Text(
                            'Maksimalna tezina po paketu: ${serviceItem.maxWeight} kg',
                            style: TextStyle(fontSize: context.sp(14)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Icon(Icons.local_atm, size: context.w(20)),
                          const SizedBox(width: 10),
                          Text(
                            'Cena po paketu: ${serviceItem.cost}',
                            style: TextStyle(fontSize: context.sp(14)),
                          ),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.mainColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: 5,
                          horizontal: 10,
                        ),
                        child: Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.block_outlined,
                                  size: 30,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.stretch,
                                    children: [
                                      Text(
                                        'Ne prevozi',
                                        style: TextStyle(
                                          fontSize: context.sp(14),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        'iz bezbednosnih razloga ne prevozi:',
                                        style: TextStyle(
                                          fontSize: context.sp(10),
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Wrap(
                                        spacing: 20,
                                        runSpacing: 8,
                                        children: [
                                          for (final restrictedItem
                                              in serviceItem.restrictedItems)
                                            restrictedContent(restrictedItem),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      Divider(color: Colors.grey.shade300, thickness: 1),
                      const SizedBox(height: 10),
                      Text(
                        'Lokacija polaska',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: context.sp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        serviceItem.destinationStart.city,
                        textAlign: TextAlign.left,
                        style: TextStyle(fontSize: context.sp(14)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.h(10)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.sms, size: context.w(25)),
                  const SizedBox(width: 10),
                  Text('Posalji poruku'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
