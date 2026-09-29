import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/transport_mode.dart';

class ServiceItemHeader extends ConsumerWidget {
  const ServiceItemHeader({super.key, required this.serviceItem});

  final ServiceItem serviceItem;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.read(languageProvider.notifier);
    final dateInfo = getDateTime(serviceItem.departureTime);
    var dayMonth = dateInfo.dayMonth.split(".");
    var departureDate = dayMonth[0];
    var departureMonth = dayMonth[1];
    var departureTime = dateInfo.time;
    var departureYear = dateInfo.year;
    var ratingText = getAverageRating(
      serviceItem.ratingHistory,
    ).toStringAsFixed(1);

    return Column(
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
            Icon(Icons.arrow_forward_sharp, size: 15, color: AppColors.primary),
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
            const SizedBox(width: 5),
            TransportMode(transport: serviceItem.transportMode, iconSize: 20),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              size: context.w(20),
              color: AppColors.primary,
            ),
            const SizedBox(width: 5),
            Text(
              '$departureDate. ${lang.translate(departureMonth.trim())}  $departureYear',
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
      ],
    );
  }
}
