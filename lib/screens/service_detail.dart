import 'package:flutter/material.dart';
import 'package:ok_ok/modal/service_item.dart';

class ServiceDetailScreen extends StatelessWidget {
  const ServiceDetailScreen({super.key, required this.serviceItem});

  final ServiceItem serviceItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', width: 100)),
      body: Column(children: [Text(serviceItem.firstName)]),
    );
  }
}
