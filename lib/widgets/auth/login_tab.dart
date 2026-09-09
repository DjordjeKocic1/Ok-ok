import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/screens/forgot_password.dart';
import 'package:ok_ok/screens/tabs.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/auth/google_button.dart';
import 'package:ok_ok/widgets/auth/legal_links.dart';

class LoginTab extends ConsumerStatefulWidget {
  const LoginTab({super.key});

  @override
  ConsumerState<LoginTab> createState() => _LoginTabState();
}

class _LoginTabState extends ConsumerState<LoginTab> {
  final _formKey = GlobalKey<FormState>();

  void _selectForgotPassword() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => ForgotPasswordScreen()));
  }

  void _submit() {
    Navigator.of(
      context,
    ).pushReplacement(MaterialPageRoute(builder: (ctx) => TabsScreen()));
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider.notifier);
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                label: Text(
                  lang.translate('loginEmailInput'),
                  style: TextStyle(fontSize: context.sp(16)),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                label: Text(
                  lang.translate('loginPasswordInput'),
                  style: TextStyle(fontSize: context.sp(16)),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _selectForgotPassword,
                child: Text(
                  lang.translate('forgotPassword'),
                  style: TextStyle(
                    color: AppColors.primary,
                    fontSize: context.sp(14),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _submit,
              child: Text(
                lang.translate('signIn'),
                style: TextStyle(fontSize: context.sp(14)),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Text(
                    lang.translate('or'),
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 14),
                  ),
                ),
                Expanded(
                  child: Divider(color: Colors.grey.shade300, thickness: 1),
                ),
              ],
            ),
            const SizedBox(height: 10),
            FormGoogle(),
            const SizedBox(height: 10),
            FormLigalLinks(),
          ],
        ),
      ),
    );
  }
}
