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
      if (transport == 'car') {
        return Icon(
          Icons.directions_car_outlined,
          size: iconSize,
          color: AppColors.primary,
        );
      }

      if (transport == 'bus') {
        return Icon(
          Icons.directions_bus_outlined,
          size: iconSize,
          color: AppColors.primary,
        );
      }

      if (transport == 'plane') {
        return Icon(Icons.flight, size: iconSize, color: AppColors.primary);
      }

      if (transport == 'train') {
        return Icon(
          Icons.train_outlined,
          size: iconSize,
          color: AppColors.primary,
        );
      }

      return Icon(
        Icons.local_shipping_outlined,
        size: iconSize,
        color: AppColors.primary,
      );
    }

    return transportContent();
  }
}
