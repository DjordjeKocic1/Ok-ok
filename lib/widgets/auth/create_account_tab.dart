import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/api/auth_api.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/error_message.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/utils/success_dialog.dart';
import 'package:ok_ok/widgets/auth/google_button.dart';
import 'package:ok_ok/widgets/auth/legal_links.dart';

class CreateAccountTab extends ConsumerStatefulWidget {
  const CreateAccountTab({super.key});

  @override
  ConsumerState<CreateAccountTab> createState() => _CreateAccountTabState();
}

class _CreateAccountTabState extends ConsumerState<CreateAccountTab> {
  final _formKey = GlobalKey<FormState>();
  var _firstName = '';
  var _lastName = '';
  var _email = '';
  var _password = '';

  bool _isLoading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    _formKey.currentState!.save();
    setState(() {
      _isLoading = true;
    });

    try {
      await AuthApi.signUp(
        firstName: _firstName,
        lastName: _lastName,
        email: _email,
        password: _password,
      );
      if (!mounted) return;

      final lang = ref.read(languageProvider.notifier);
      final tabController = DefaultTabController.of(context);
      showSuccessDialog(
        context,
        lang.translate('successAccountCreate'),
        onConfirm: () {
          FocusManager.instance.primaryFocus?.unfocus();
          _formKey.currentState?.reset();
          tabController.animateTo(0);
        },
      );
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
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(15),
                ),
                label: Text(
                  lang.translate('firstName'),
                  style: TextStyle(
                    fontSize: context.sp(16),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) => _firstName = value!,
            ),
            const SizedBox(height: 20),
            TextFormField(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(15),
                ),
                label: Text(
                  lang.translate('lastName'),
                  style: TextStyle(
                    fontSize: context.sp(16),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) => _lastName = value!,
            ),
            const SizedBox(height: 20),
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
                prefixIcon: Icon(Icons.email_outlined),
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
                prefixIcon: Icon(Icons.lock_outline),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) => _password = value!,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isLoading ? null : _submit,
              child: _isLoading
                  ? SizedBox(
                      width: context.w(20),
                      height: context.w(20),
                      child: const CircularProgressIndicator(strokeWidth: 2),
                    )
                  : Text(
                      lang.translate('createAccount'),
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
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
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
