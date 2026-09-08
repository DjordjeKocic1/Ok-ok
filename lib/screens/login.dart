import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/data/translations.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/auth/create_account_tab.dart';
import 'package:ok_ok/widgets/auth/login_tab.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lang = ref.watch(languageProvider.notifier);
    final currentLang = ref.watch(languageProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color(0xFFE9E5FA),
                  Color(0xFFF7F6FC),
                  Color(0xFFFFFFFF),
                ],
                stops: [0.0, 0.4, 1.0],
              ),
            ),
            child: SafeArea(
              child: ScreenPadding(
                extra: const EdgeInsets.only(top: 20, bottom: 10),
                child: Column(
                  children: [
                    Container(
                      height: context.h(250),
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(
                            'assets/images/login_background.png',
                          ),
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(height: context.h(24)),
                          Image.asset(
                            'assets/images/logo.png',
                            width: context.w(250),
                          ),
                          Text(
                            lang.translate("peopleHelps"),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: context.sp(15),
                            ),
                          ),
                          Text(
                            lang.translate("peopleService"),
                            style: TextStyle(fontSize: context.sp(12)),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: DefaultTabController(
                        length: 2,
                        child: Column(
                          children: [
                            TabBar(
                              tabAlignment: TabAlignment.fill,
                              labelColor: AppColors.primaryDark,
                              unselectedLabelColor: AppColors.textSecondary,
                              labelStyle: TextStyle(
                                fontSize: context.sp(16),
                                fontWeight: FontWeight.bold,
                              ),
                              indicatorColor: AppColors.primary,
                              indicatorSize: TabBarIndicatorSize.tab,
                              tabs: [
                                Tab(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(lang.translate("signIn")),
                                  ),
                                ),
                                Tab(
                                  child: FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      lang.translate("createAccount"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: context.h(20)),
                            Expanded(
                              child: TabBarView(
                                physics: const NeverScrollableScrollPhysics(),
                                children: [LoginTab(), CreateAccountTab()],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 25,
            right: 20,
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: currentLang,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  color: AppColors.primaryDark,
                ),
                style: TextStyle(
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w600,
                  fontSize: context.sp(15),
                ),
                items: [
                  for (final countryCode in translationData.keys)
                    DropdownMenuItem(
                      value: countryCode,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(3),
                              child: CountryFlag.fromLanguageCode(
                                countryCode,
                                theme: ImageTheme(
                                  width: context.w(30),
                                  height: context.h(20),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              countryCode.toUpperCase(),
                              style: TextStyle(
                                fontSize: context.sp(14),
                                fontWeight: FontWeight.w500,
                                color: AppColors.primaryDark,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                ],
                onChanged: (v) {
                  if (v != null) {
                    ref.read(languageProvider.notifier).setLanguage(v);
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
