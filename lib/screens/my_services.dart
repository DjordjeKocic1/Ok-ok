import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/screens/add_service.dart';
import 'package:ok_ok/utils/formatters.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/transport_mode.dart';

class MyServicesScreen extends StatefulWidget {
  const MyServicesScreen({super.key});

  @override
  State<MyServicesScreen> createState() => _MyServicesScreenState();
}

class _MyServicesScreenState extends State<MyServicesScreen> {
  void _goToAddService() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => AddServiceScreen()));
  }

  Future<void> _confirmDelete() async {
    await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Obriši uslugu'),
        content: const Text(
          'Da li si siguran da želiš da obrišeš ovu uslugu? Ova akcija se ne može poništiti.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Ne'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx, true),
            style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
            child: const Text('Da, obriši'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Moje usluge',
          style: TextStyle(
            fontSize: context.sp(25),
            fontWeight: FontWeight.bold,
            height: 1.2,
          ),
        ),
        Text(
          'Pogledaj i upravljaj svojim objavljenim uslugama',
          style: TextStyle(
            fontSize: context.sp(14),
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView.builder(
            itemCount: userFakeData[0].services.length,
            itemBuilder: (ctx, index) {
              final dateInfo = getDateTime(
                userFakeData[0].services[index].departureTime,
              );
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
                              transport:
                                  userFakeData[0].services[index].transportMode,
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
                                      userFakeData[0]
                                          .services[index]
                                          .destinationStart
                                          .city,
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
                                        userFakeData[0]
                                            .services[index]
                                            .destinationEnd
                                            .city,
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
                          IconButton(
                            onPressed: _confirmDelete,
                            icon: Icon(
                              Icons.cancel_outlined,
                              color: Colors.redAccent,
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
                                  '${userFakeData[0].services[index].spotsAvailable} mesta za paket(e)',
                                  style: TextStyle(fontSize: context.sp(14)),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            '\$${userFakeData[0].services[index].cost}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.sp(14),
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        ElevatedButton(
          onPressed: _goToAddService,
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
