import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/screens/request.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';
import 'package:ok_ok/widgets/service_item_header.dart';

class ServiceDetailScreen extends StatefulWidget {
  const ServiceDetailScreen({super.key, required this.serviceItem});

  final ServiceItem serviceItem;

  @override
  State<ServiceDetailScreen> createState() => _ServiceDetailScreenState();
}

class _ServiceDetailScreenState extends State<ServiceDetailScreen> {
  void _goToRequest(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => RequestScreen(serviceItem: widget.serviceItem),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text(
          'Detailji',
          style: TextStyle(
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.share))],
      ),
      body: SingleChildScrollView(
        child: ScreenPadding(
          extra: const EdgeInsets.only(bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ServiceItemHeader(serviceItem: widget.serviceItem),
              const SizedBox(height: 10),
              Divider(color: Colors.grey.shade300, thickness: 1),
              const SizedBox(height: 10),
              Column(
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
                    widget.serviceItem.tripNote,
                    style: TextStyle(fontSize: context.sp(14)),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Icon(
                        Icons.card_travel,
                        size: context.w(20),
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Slobodna mesta za paket(e): ${widget.serviceItem.spotsAvailable}',
                        style: TextStyle(fontSize: context.sp(14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.scale_outlined,
                        size: context.w(20),
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Maksimalna tezina po paketu: ${widget.serviceItem.maxWeight} kg',
                        style: TextStyle(fontSize: context.sp(14)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    children: [
                      Icon(
                        Icons.local_atm,
                        size: context.w(20),
                        color: AppColors.primary,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'Cena po paketu: ${widget.serviceItem.cost}',
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
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
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
                                crossAxisAlignment: CrossAxisAlignment.stretch,
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
                                          in widget.serviceItem.restrictedItems)
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
                ],
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  _goToRequest(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: context.h(10)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.person_add, size: context.w(25)),
                    const SizedBox(width: 10),
                    Text('Posalji zahtev'),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
