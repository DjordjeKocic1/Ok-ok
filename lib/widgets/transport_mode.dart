import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';

class TransportMode extends StatelessWidget {
  const TransportMode({
    super.key,
    required this.transport,
    required this.iconSize,
  });

  final String transport;
  final double iconSize;

  @override
  Widget build(BuildContext context) {
    Widget transportContent() {
      if (transport == 'Car') {
        return Icon(
          Icons.directions_car_outlined,
          size: iconSize,
          color: AppColors.primary,
        );
      }
      if (transport == 'Airplan') {
        return Icon(Icons.flight, size: iconSize, color: AppColors.primary);
      }

      if (transport == 'Truck') {
        return Icon(
          Icons.local_shipping_outlined,
          size: iconSize,
          color: AppColors.primary,
        );
      }

      return Icon(
        Icons.directions_boat_outlined,
        size: iconSize,
        color: AppColors.primary,
      );
    }

    return transportContent();
  }
}
