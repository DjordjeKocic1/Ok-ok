import 'package:flutter/material.dart';

class PasswordResetInfo extends StatelessWidget {
  const PasswordResetInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/email-sent.png', width: 200),
          Text(
            'Posali smo Vam link na vasoj adresi e-poste sa instrukcijama kako da obnovite lozinku.',
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
