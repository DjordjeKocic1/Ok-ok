import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/providers/service_provider.dart';
import 'package:ok_ok/screens/service_detail.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';

class ServicesList extends ConsumerStatefulWidget {
  const ServicesList({
    super.key,
    required this.destinationStart,
    required this.destinationEnd,
    required this.onBack,
  });

  final String destinationStart;
  final String destinationEnd;
  final VoidCallback onBack;

  @override
  ConsumerState<ServicesList> createState() => _ServicesListState();
}

class _ServicesListState extends ConsumerState<ServicesList> {
  void _goToDetails(BuildContext context, ServiceItem serviceData) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => ServiceDetailScreen(serviceItem: serviceData),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);
    final service = ref.read(serviceProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                onTap: widget.onBack,
                child: Row(
                  children: [
                    Icon(
                      Icons.arrow_back,
                      size: context.w(18),
                      color: AppColors.primary,
                    ),
                    const SizedBox(width: 5),
                    Text(
                      lang.translate('backToSearch'),
                      style: TextStyle(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                        fontSize: context.sp(14),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Text(
          lang.translate('availableServices'),
          style: TextStyle(
            fontSize: context.sp(25),
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          lang.translate('findSomeone'),
          style: TextStyle(
            fontSize: context.sp(14),
            fontWeight: FontWeight.bold,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: service.length,
            itemBuilder: (ctx, index) {
              final dateInfo = getDateTime(service[index].departureTime);
              var dayMonth = dateInfo.dayMonth.split(".");
              var departureDate = dayMonth[0];
              var departureMonth = dayMonth[1];
              var departureTime = dateInfo.time;
              var isTomorrow = dateInfo.isTomorrow;
              var badgeText = isTomorrow
                  ? lang.translate('goTomorrow')
                  : '${lang.translate('goes')} $departureDate . ${lang.translate(departureMonth.trim())}';
              var ratingText = getAverageRating(
                service[index].ratingHistory,
              ).toStringAsFixed(1);

              Widget transportModeContent(String transport) {
                if (transport == 'Car') {
                  return Icon(
                    Icons.directions_car_outlined,
                    size: 20,
                    color: AppColors.primary,
                  );
                }
                return Icon(Icons.flight, size: 20, color: AppColors.primary);
              }

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
                    _goToDetails(context, service[index]);
                  },
                  child: Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(15),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        service[index].firstName,
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 1,
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
                                          Text(
                                            ratingText,
                                            style: TextStyle(
                                              fontSize: context.sp(14),
                                            ),
                                          ),
                                          const SizedBox(width: 2),
                                          Text(
                                            '(${service[index].ratingHistory.length.toString()})',
                                            style: TextStyle(
                                              fontSize: context.sp(14),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.fadeSuccess,
                                    border: Border.all(
                                      color: AppColors.successPrimary,
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    badgeText,
                                    style: TextStyle(
                                      color: AppColors.successPrimary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: context.sp(12),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  service[index].destinationStart.city,
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
                                    service[index].destinationEnd.city,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: context.sp(16),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 5),
                                transportModeContent(
                                  service[index].transportMode,
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_month_outlined,
                                  size: 20,
                                  color: AppColors.primary,
                                ),
                                const SizedBox(width: 5),
                                Text(
                                  '$departureDate. ${lang.translate(departureMonth.trim())} - $departureTime',
                                  style: TextStyle(fontSize: context.sp(14)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Text(
                              '${lang.translate('freeSpace')} ${service[index].spotsAvailable}',
                              style: TextStyle(fontSize: context.sp(14)),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 20,
                        child: Text(
                          '\$${service[index].cost}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: context.sp(16),
                            color: AppColors.primary,
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
    );
  }
}
