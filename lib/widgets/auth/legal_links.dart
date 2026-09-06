import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/screens/legal.dart';

class FormLigalLinks extends ConsumerWidget {
  const FormLigalLinks({super.key});

  void _selectLegalLink(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => LegalScreen()));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider.notifier);
    return Align(
      child: RichText(
        textAlign: TextAlign.center,
        text: TextSpan(
          style: TextStyle(
            color: AppColors.primaryDark,
            fontSize: 16,
            height: 1.5,
          ),
          children: [
            TextSpan(text: '${lang.translate("byContinue")} '),
            TextSpan(
              text: lang.translate("privacy"),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _selectLegalLink(context);
                },
            ),
            TextSpan(text: ' ${lang.translate('and')} '),
            TextSpan(
              text: lang.translate('terms'),
              style: const TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.bold,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  _selectLegalLink(context);
                },
            ),
            const TextSpan(text: '.'),
          ],
        ),
      ),
    );
  }
}
