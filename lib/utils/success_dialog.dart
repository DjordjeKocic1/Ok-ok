import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';

Future<void> showSuccessDialog(
  BuildContext context,
  String text, {
  VoidCallback? onConfirm,
}) {
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(
        Icons.check_circle_outlined,
        color: AppColors.successPrimary,
        size: 36,
      ),
      content: Text(
        text,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: context.sp(14)),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(ctx);
            onConfirm?.call();
          },
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
