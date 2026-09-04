import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalScreen extends StatefulWidget {
  const LegalScreen({super.key});

  @override
  State<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends State<LegalScreen> {
  bool _isLoading = false;

  void _openUrl(BuildContext context, String url) async {
    setState(() => _isLoading = true);
    final uri = Uri.parse(url);
    try {
      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!success && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Ne mogu da otvorim link')));
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Greška: $e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', width: 100)),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.ballot_outlined),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _openUrl(context, "https://www.google.com/");
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text('Uslovi koriscenja'),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.ballot_outlined),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _openUrl(context, "https://www.google.com/");
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text('Politika privatnosti'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
