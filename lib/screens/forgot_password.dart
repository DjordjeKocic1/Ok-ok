import 'package:flutter/material.dart';
import 'package:ok_ok/widgets/auth/password_reset_info.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();

  bool _isEmailSent = false;

  void _submitEmail() {
    setState(() {
      _isEmailSent = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Form(
      key: _formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Column(
              children: [
                Text('Zaboravio si lozinku?', style: TextStyle(fontSize: 20)),
                const SizedBox(height: 10),
                Text(
                  'Upisi svoju adresu e-poste i mi cemo ti poslati instrukcije kako da obnovite lozinku',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              label: const Text('Upisi svoju adresu e-poste'),
              prefixIcon: const Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(onPressed: _submitEmail, child: const Text('Nastavi')),
        ],
      ),
    );
    if (_isEmailSent) {
      content = PasswordResetInfo();
    }
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', width: 100)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: content,
      ),
    );
  }
}
