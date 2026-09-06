import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';

class FormGoogle extends ConsumerWidget {
  const FormGoogle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider.notifier);
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
              Text(
                lang.translate("continueWithGoogle"),
                style: TextStyle(color: AppColors.primaryDark),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
