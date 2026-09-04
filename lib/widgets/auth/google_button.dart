import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';

class FormGoogle extends StatelessWidget {
  const FormGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.surface,
            overlayColor: AppColors.primaryDark,
            side: BorderSide(color: AppColors.border, width: 1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            elevation: 0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(width: 30, 'assets/images/google-icon.png'),
              const SizedBox(width: 8),
              const Text(
                'Nastavi sa google nalogom',
                style: TextStyle(color: AppColors.primaryDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
