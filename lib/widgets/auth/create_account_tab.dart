import 'package:flutter/material.dart';
import 'package:ok_ok/widgets/auth/google_button.dart';
import 'package:ok_ok/widgets/auth/legal_links.dart';

class CreateAccountTab extends StatefulWidget {
  const CreateAccountTab({super.key});

  @override
  State<CreateAccountTab> createState() => _CreateAccountTabState();
}

class _CreateAccountTabState extends State<CreateAccountTab> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: 10),
            TextFormField(
              decoration: const InputDecoration(
                label: Text('Ime i prezime'),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                label: Text('Adresa e-poste'),
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                label: Text('Lozinka'),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 20),
            TextFormField(
              keyboardType: TextInputType.visiblePassword,
              decoration: const InputDecoration(
                label: Text('Potvrdi lozinku'),
                prefixIcon: Icon(Icons.lock_outline),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Napravi nalog'),
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
                    'ili',
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
            FormLoginLegal(),
          ],
        ),
      ),
    );
  }
}
