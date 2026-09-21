import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/service_item.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';
import 'package:ok_ok/widgets/service_item_header.dart';

class RequestScreen extends StatefulWidget {
  const RequestScreen({super.key, required this.serviceItem});

  final ServiceItem serviceItem;

  @override
  State<RequestScreen> createState() => _RequestScreenState();
}

class _RequestScreenState extends State<RequestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Posalji zahtev',
          style: TextStyle(
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: ScreenPadding(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Popuni osnovne informacije i dodaj detalje o paketu koji zelis da preveze',
                style: TextStyle(
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.bold,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 20),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ServiceItemHeader(serviceItem: widget.serviceItem),
              ),
              const SizedBox(height: 20),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.inventory_2_outlined,
                    size: 25,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sta se prevozi?',
                          style: TextStyle(
                            fontSize: context.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Napisi sta staljes ili prevozis (npr. paket, dokumenta, licne stvari...).',
                          style: TextStyle(
                            fontSize: context.sp(12),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 2,
                maxLines: 2,
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  label: Text(
                    'Opis paketa',
                    style: TextStyle(
                      fontSize: context.sp(14),
                      color: AppColors.textSecondary,
                    ),
                  ),
                  suffixIcon: Icon(
                    Icons.inventory_2_outlined,
                    size: 30,
                    color: AppColors.border,
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    Icons.scale_outlined,
                    size: 25,
                    color: AppColors.primary,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Tezina paketa',
                          style: TextStyle(
                            fontSize: context.sp(16),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Unesi probliznu tezinu paketa.',
                          style: TextStyle(
                            fontSize: context.sp(12),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: InputDecoration(
                  label: Text(
                    'npr. 1',
                    style: TextStyle(
                      fontSize: context.sp(14),
                      color: AppColors.textSecondary,
                    ),
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Align(
                      alignment: Alignment.centerRight,
                      widthFactor: 1,
                      child: Text(
                        'Kg',
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                  color: AppColors.mainColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.star, size: 25, color: AppColors.primary),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Specijalni zahtev',
                                style: TextStyle(
                                  fontSize: context.sp(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Imas dodatne zahteve, ogranicenja ili nesto sto bi vozac trebao da zna? Napisi ovde.',
                                style: TextStyle(
                                  fontSize: context.sp(12),
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.multiline,
                      minLines: 3,
                      maxLines: 3,
                      maxLength: 500,
                      decoration: InputDecoration(
                        alignLabelWithHint: true,
                        label: Text(
                          'npr. lomljivo, hitno, usputna stanica...',
                          style: TextStyle(
                            fontSize: context.sp(12),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.savings_outlined,
                          size: 25,
                          color: AppColors.primary,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Ponudi više para ',
                                      style: TextStyle(
                                        fontSize: context.sp(16),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    WidgetSpan(
                                      alignment: PlaceholderAlignment.middle,
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 2,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary.withValues(
                                            alpha: 0.1,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          'Opcionalno',
                                          style: TextStyle(
                                            fontSize: context.sp(11),
                                            color: AppColors.primary,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Ako zelis da ponudis vecu cenu za ovaj zahtev, upisi iznos koji si spreman da platis.',
                                style: TextStyle(
                                  fontSize: context.sp(12),
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    TextFormField(
                      keyboardType: TextInputType.number,
                      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                      decoration: InputDecoration(
                        label: Text(
                          'npr. 5',
                          style: TextStyle(
                            fontSize: context.sp(14),
                            color: AppColors.textSecondary,
                          ),
                        ),
                        suffixIcon: Icon(
                          Icons.euro_outlined,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                  ],
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
