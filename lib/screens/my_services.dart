import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/service_provider.dart';
import 'package:ok_ok/screens/add_service.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/transport_mode.dart';

class MyServicesScreen extends ConsumerWidget {
  const MyServicesScreen({super.key});

  void _goToAddService(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddServiceScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userServices = ref.watch(serviceProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moje usluge i zahtevi',
          style: TextStyle(
            fontSize: context.sp(25),
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Text(
          'Pogledaj i upravljaj svojim objavljenim uslugama i poslatim zahtevima',
          style: TextStyle(
            fontSize: context.sp(14),
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: userServices.when(
            error: (e, _) => Center(child: Text(e.toString())),
            loading: () => const Center(child: CircularProgressIndicator()),
            data: (services) {
              if (services.isEmpty) {
                return Center(
                  child: Text(
                    'Nema objavljenih usluga',
                    style: TextStyle(fontSize: context.sp(14)),
                  ),
                );
              }
              return ListView.builder(
                itemCount: services.length,
                itemBuilder: (ctx, index) {
                  final dateInfo = getDateTime(services[index].departureTime);
                  var dayMonth = dateInfo.dayMonth.split(".");
                  var departureDate = dayMonth[0];
                  var departureMonth = dayMonth[1];
                  var departureTime = dateInfo.time;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(color: AppColors.border),
                    ),
                    color: AppColors.background,
                    clipBehavior: Clip.hardEdge,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(6),
                                decoration: BoxDecoration(
                                  color: AppColors.border,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TransportMode(
                                  transport: services[index].transportMode,
                                  iconSize: 30,
                                ),
                              ),
                              const SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        Text(
                                          services[index].destinationStart.city,
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
                                            services[index].destinationEnd.city,
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
                                        Icon(
                                          Icons.calendar_today_outlined,
                                          size: 20,
                                        ),
                                        const SizedBox(width: 5),
                                        Text(
                                          '$departureDate. ${departureMonth.trim()} - $departureTime',
                                          style: TextStyle(
                                            fontSize: context.sp(14),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 10),
                          Divider(color: AppColors.textSecondary, thickness: 1),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    Icon(Icons.inventory_2_outlined, size: 20),
                                    const SizedBox(width: 10),
                                    Text(
                                      '${services[index].spotsAvailable} mesta za paket(e)',
                                      style: TextStyle(
                                        fontSize: context.sp(14),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$${services[index].cost}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: context.sp(14),
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 15),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(6),
                                  decoration: const BoxDecoration(
                                    color: AppColors.secondaryMainColor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.person_2_rounded,
                                    size: context.w(20),
                                    color: AppColors.primary,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Text.rich(
                                  TextSpan(
                                    style: TextStyle(fontSize: context.sp(12)),
                                    children: [
                                      TextSpan(
                                        text:
                                            '${services[index].requests.length} zahtev(a)',
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const TextSpan(text: ' za ovu uslugu'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
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
                'Dodaj uslugu',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.sp(15),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
