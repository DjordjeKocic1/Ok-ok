import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/widgets/auth/password_reset_info.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isEmailSent = false;

  void _submitEmail() {
    setState(() {
      _isEmailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider.notifier);
    Widget content = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text(
                  lang.translate("forgotPassword"),
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 10),
                Text(
                  lang.translate("writeEmailForgotPassword"),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: Text(lang.translate('writeEmailInputForgotPassword')),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: _submitEmail,
            child: Text(lang.translate("continue")),
          ),
        ],
      ),
    );
    if (_isEmailSent) {
      content = PasswordResetInfo();
    }
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', width: 100)),
      body: ScreenPadding(child: content),
    );
  }
}
