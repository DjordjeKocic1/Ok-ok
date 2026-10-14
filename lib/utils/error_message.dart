import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';

const _knownErrors = {
  'EMAIL_ALREADY_EXISTS',
  'EMAIL_DONT_EXISTS',
  'EMAIL_NOT_VALID_FORMAT',
  'WRONG_PASSWORD',
  'PASSWORD_TOO_SHORT',
  'PASSWORD_NEEDS_NUMBER',
  'INVALID_TOKEN',
};

String errorMessage(Object? error, String Function(String key) translate) {
  final code = error.toString().replaceFirst('Exception: ', '').trim();

  if (error.toString().contains('SocketException') ||
      error.toString().contains('ClientException')) {
    return 'No internet connect';
  }

  if (_knownErrors.contains(code)) {
    return translate(code);
  }

  return translate('somethingWentWrong');
}

Future<void> showErrorDialog(
  BuildContext context,
  Object? error,
  WidgetRef ref,
) {
  final lang = ref.read(languageProvider.notifier);
  return showDialog(
    context: context,
    builder: (ctx) => AlertDialog(
      icon: const Icon(Icons.error_outline, color: Colors.red, size: 36),
      content: Text(
        errorMessage(error, lang.translate),
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: context.sp(14)),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
