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

    return Scaffold(
      appBar: AppBar(
        title: Image.asset('assets/images/logo.png', width: context.w(100)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: ScreenPadding(
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
                    Text(
                      ratingText,
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
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
                    Flexible(
                      child: Text(
                        serviceItem.destinationStart,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: context.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
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
                        serviceItem.destinationEnd,
                        overflow: TextOverflow.ellipsis,
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
                    Text(
                      departureTime,
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Divider(color: Colors.grey.shade300, thickness: 1),
                const SizedBox(height: 10),
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
                    Icon(Icons.monitor_weight, size: context.w(20)),
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
                const SizedBox(height: 5),
                for (final restrictedItem in serviceItem.restrictedItems)
                  Text(restrictedItem),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
