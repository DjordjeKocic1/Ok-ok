import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/api/auth_api.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/providers/user_provider.dart';
import 'package:ok_ok/screens/forgot_password.dart';
import 'package:ok_ok/screens/tabs.dart';
import 'package:ok_ok/utils/error_message.dart';
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
  var _email = '';
  var _password = '';

  bool _isLoading = false;

  void _selectForgotPassword() {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (ctx) => ForgotPasswordScreen()));
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });
    try {
      await AuthApi.signIn(email: _email, password: _password);
      await ref.read(userProvider.notifier).getUser();

      if (!mounted) return;

      final userState = ref.read(userProvider);

      if (userState.hasError) {
        showErrorDialog(context, userState.error, ref);
        return;
      }

      Navigator.of(
        context,
      ).pushReplacement(MaterialPageRoute(builder: (ctx) => TabsScreen()));
    } catch (e) {
      if (!mounted) return;
      showErrorDialog(context, e, ref);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(15),
                ),
                label: Text(
                  lang.translate('loginEmailInput'),
                  style: TextStyle(
                    fontSize: context.sp(16),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: const Icon(Icons.email_outlined),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(15),
                ),
                label: Text(
                  lang.translate('loginPasswordInput'),
                  style: TextStyle(
                    fontSize: context.sp(16),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: const Icon(Icons.lock_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) => _password = value!,
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
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? SizedBox(
                      width: context.w(20),
                      height: context.w(20),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      lang.translate('signIn'),
                      style: TextStyle(fontSize: context.sp(15)),
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
