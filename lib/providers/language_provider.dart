import 'package:flutter_riverpod/legacy.dart';
import 'package:ok_ok/data/translations.dart';

class LanguageProviderNotifier extends StateNotifier<String> {
  LanguageProviderNotifier() : super('en');

  void setLanguage(String languageCode) {
    if (state == languageCode) return;
    state = languageCode;
  }

  String translate(String key) {
    return translationData[state]?[key] ?? key;
  }
}

final languageProvider = StateNotifierProvider((ref) {
  return LanguageProviderNotifier();
});
