import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class Language extends ConsumerStatefulWidget {
  const Language({super.key});

  @override
  ConsumerState<Language> createState() => _LanguageState();
}

class _LanguageState extends ConsumerState<Language> {
  String _selectedLang = '';

  @override
  Widget build(BuildContext context) {
    final currentLang = ref.watch(languageProvider);
    return ScreenPadding(
      extra: EdgeInsets.symmetric(vertical: 20),
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
                child: Icon(Icons.language, size: 40, color: AppColors.primary),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Select language',
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Choose your preferred language',
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
          RadioGroup(
            groupValue: _selectedLang.isEmpty ? currentLang : _selectedLang,
            onChanged: (value) => setState(() => _selectedLang = value!),
            child: Column(
              children: [
                RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: CountryFlag.fromLanguageCode(
                          'en',
                          theme: ImageTheme(
                            shape: const Circle(),
                            width: context.w(30),
                            height: context.h(30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('English'),
                    ],
                  ),
                  value: 'en',
                  activeColor: AppColors.primary,
                ),
                RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: CountryFlag.fromLanguageCode(
                          'sr',
                          theme: ImageTheme(
                            shape: const Circle(),
                            width: context.w(30),
                            height: context.h(30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Serbian'),
                    ],
                  ),
                  value: 'sr',
                  activeColor: AppColors.primary,
                ),
                RadioListTile(
                  controlAffinity: ListTileControlAffinity.trailing,
                  title: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: CountryFlag.fromLanguageCode(
                          'de',
                          theme: ImageTheme(
                            shape: const Circle(),
                            width: context.w(30),
                            height: context.h(30),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Text('Deutsch'),
                    ],
                  ),
                  value: 'de',
                  activeColor: AppColors.primary,
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              ref.read(languageProvider.notifier).setLanguage(_selectedLang);
            },
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
    );
  }
}
