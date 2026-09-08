import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';

class PasswordResetInfo extends ConsumerWidget {
  const PasswordResetInfo({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider.notifier);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('assets/images/email-sent.png', width: context.w(200)),
          Text(
            lang.translate("linkSentToEmail"),
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: context.sp(14)),
          ),
        ],
      ),
    );
  }
}
