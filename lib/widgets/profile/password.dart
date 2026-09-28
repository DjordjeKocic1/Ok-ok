import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class Password extends StatefulWidget {
  const Password({super.key});

  @override
  State<Password> createState() => _PasswordState();
}

class _PasswordState extends State<Password> {
  final _formKey = GlobalKey<FormState>();
  final _currentPasswordController = TextEditingController();
  var _newPassword = '';

  void _onResetPassword() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      print({
        "currentPassword": _currentPasswordController.text,
        "newPassword": _newPassword,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget idDocumentVerifyContent() {
      if (userFakeData[0].idVerified) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.fadeSuccess,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check, color: AppColors.successPrimary, size: 15),
              const SizedBox(width: 3),
              Text(
                'Verified',
                style: TextStyle(
                  fontSize: context.sp(12),
                  color: AppColors.successPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        );
      }

      return TextButton(
        style: TextButton.styleFrom(backgroundColor: AppColors.mainColor),
        onPressed: () {},
        child: Text('Verify'),
      );
    }

    ;

    return ScreenPadding(
      extra: EdgeInsets.only(top: 20),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: const BoxDecoration(
                    color: AppColors.mainColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.admin_panel_settings_outlined,
                    size: 40,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Security and Password',
                        style: TextStyle(
                          fontSize: context.sp(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'You can verify your identity and update your password here.',
                        style: TextStyle(
                          fontSize: context.sp(12),
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton.outlined(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.close_outlined),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(12),
                  topRight: Radius.circular(12),
                ),
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Email',
                          style: TextStyle(fontSize: context.sp(14)),
                        ),
                        Text(
                          userFakeData[0].email,
                          style: TextStyle(
                            fontSize: context.sp(14),
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                    decoration: BoxDecoration(
                      color: AppColors.fadeSuccess,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.check,
                          color: AppColors.successPrimary,
                          size: 15,
                        ),
                        const SizedBox(width: 3),
                        Text(
                          'Verified',
                          style: TextStyle(
                            fontSize: context.sp(12),
                            color: AppColors.successPrimary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.background,
                border: Border.all(color: AppColors.border),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'ID document',
                          style: TextStyle(fontSize: context.sp(14)),
                        ),
                        if (!userFakeData[0].idVerified)
                          Text(
                            'Not verified',
                            style: TextStyle(
                              fontSize: context.sp(12),
                              color: AppColors.textSecondary,
                            ),
                          ),
                      ],
                    ),
                  ),
                  idDocumentVerifyContent(),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Change password',
              style: TextStyle(
                fontSize: context.sp(15),
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Current password',
              style: TextStyle(fontSize: context.sp(14)),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _currentPasswordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                label: Text(
                  'Enter current password',
                  style: TextStyle(fontSize: context.sp(14)),
                ),
                prefixIcon: Icon(Icons.lock, color: AppColors.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ne može da bude prazno';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            Text('New password', style: TextStyle(fontSize: context.sp(14))),
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                label: Text(
                  'Enter new password',
                  style: TextStyle(fontSize: context.sp(14)),
                ),
                prefixIcon: Icon(Icons.lock, color: AppColors.primary),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Ne može da bude prazno';
                }
                if (value == _currentPasswordController.text) {
                  return 'Nova lozinka mora biti drugačija od stare';
                }
                if (value.length >= 5) {
                  return 'Lozinka mora imati bar 5 karaktera';
                }
                return null;
              },
              onSaved: (value) {
                _newPassword = value!;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: _onResetPassword,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: context.h(10)),
              ),
              child: Text(
                'Apply',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: context.sp(15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
