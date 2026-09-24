import 'package:flutter/material.dart';
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
    return ScreenPadding(
      extra: EdgeInsets.symmetric(vertical: 20),
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
                    Icons.password_outlined,
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
                        'Password',
                        style: TextStyle(
                          fontSize: context.sp(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'You can update your password here.',
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
            Text(
              'Current password',
              style: TextStyle(fontSize: context.sp(12)),
            ),
            const SizedBox(height: 5),
            TextFormField(
              controller: _currentPasswordController,
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(12),
                ),
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
            Text('New password', style: TextStyle(fontSize: context.sp(12))),
            const SizedBox(height: 5),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(12),
                  vertical: context.h(12),
                ),
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
                if (value.length < 6) {
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
                  fontSize: context.sp(14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
