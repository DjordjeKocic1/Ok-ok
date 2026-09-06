import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';
import 'package:url_launcher/url_launcher.dart';

class LegalScreen extends ConsumerStatefulWidget {
  const LegalScreen({super.key});

  @override
  ConsumerState<LegalScreen> createState() => _LegalScreenState();
}

class _LegalScreenState extends ConsumerState<LegalScreen> {
  bool _isLoading = false;

  void _openUrl(String url) async {
    final lang = ref.read(languageProvider.notifier);
    setState(() => _isLoading = true);
    final uri = Uri.parse(url);
    try {
      final success = await launchUrl(
        uri,
        mode: LaunchMode.externalApplication,
      );
      if (!success && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(lang.translate('cantOpenLink'))));
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$e')));
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.watch(languageProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Image.asset('assets/images/logo.png', width: 100)),
      body: ScreenPadding(
        child: Column(
          children: [
            Row(
              children: [
                Icon(Icons.ballot_outlined),
                TextButton(
                  onPressed: _isLoading
                      ? null
                      : () {
                          _openUrl("https://www.google.com/");
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text(lang.translate("terms")),
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
                          _openUrl("https://www.google.com/");
                        },
                  child: _isLoading
                      ? const SizedBox(
                          height: 16,
                          width: 16,
                          child: CircularProgressIndicator(),
                        )
                      : Text(lang.translate('privacy')),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
