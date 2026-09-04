import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/screens/legal.dart';

class FormLoginLegal extends StatelessWidget {
  const FormLoginLegal({super.key});

  void _selectLegalLink(BuildContext context) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => LegalScreen()));
  }

  @override
  Widget build(BuildContext context) {
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
            const TextSpan(text: 'Nastavkom, prihvatate naše '),
            TextSpan(
              text: 'Uslove korišćenja',
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
            const TextSpan(text: ' i '),
            TextSpan(
              text: 'Politiku privatnosti',
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
