import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/profile/about.dart';
import 'package:ok_ok/widgets/profile/faqs.dart';
import 'package:ok_ok/widgets/profile/language.dart';
import 'package:ok_ok/widgets/profile/password.dart';
import 'package:ok_ok/widgets/profile/personal_information.dart';
import 'package:ok_ok/widgets/profile/ratings.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  ProfileTab? _selectedTab;

  void _openProfileTab() {
    Widget tab = const SizedBox.shrink();

    switch (_selectedTab) {
      case ProfileTab.personal:
        tab = PersonalInformation();
        break;
      case ProfileTab.rating:
        tab = Ratings();
        break;
      case ProfileTab.password:
        tab = Password();
        break;
      case ProfileTab.language:
        tab = Language();
        break;
      case ProfileTab.faqs:
        tab = Faqs();
        break;
      case ProfileTab.about:
        tab = About();
        break;
      case null:
        return;
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) => SizedBox(width: double.infinity, child: tab),
    );
  }

  Widget _profileTab(
    IconData icon,
    String title,
    String subTitle,
    ProfileTab id,
  ) {
    return Ink(
      decoration: BoxDecoration(
        color: _selectedTab == id ? AppColors.mainColor : AppColors.background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.border),
      ),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedTab = id;
            _openProfileTab();
          });
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 15),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: AppColors.border,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 30,
                  color: _selectedTab == id
                      ? AppColors.primary
                      : AppColors.primaryDark,
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: TextStyle(fontSize: context.sp(15))),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: _selectedTab == id
                            ? FontWeight.bold
                            : FontWeight.normal,
                        color: _selectedTab == id
                            ? AppColors.primaryDark
                            : AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: AppColors.textSecondary),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);
    ref.watch(languageProvider);
    final profileTabs = <Widget>[
      _profileTab(
        Icons.person_outline_outlined,
        lang.translate('personalInfo'),
        lang.translate('personalInfo'),
        ProfileTab.personal,
      ),
      _profileTab(
        Icons.star_half_outlined,
        lang.translate('rating'),
        lang.translate('giveRating'),
        ProfileTab.rating,
      ),
      _profileTab(
        Icons.admin_panel_settings_outlined,
        lang.translate('security'),
        lang.translate('security'),
        ProfileTab.password,
      ),
      _profileTab(
        Icons.language_outlined,
        lang.translate('language'),
        lang.translate('chooseAppLanguage'),
        ProfileTab.language,
      ),
      _profileTab(
        Icons.quiz_outlined,
        lang.translate('helpAndSupport'),
        lang.translate('contactUs'),
        ProfileTab.faqs,
      ),
      _profileTab(
        Icons.info_outlined,
        lang.translate('aboutOkok'),
        lang.translate('termsAndPolicy'),
        ProfileTab.about,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            userFakeData[0].firstName,
            style: TextStyle(
              fontSize: context.sp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            userFakeData[0].email,
            style: TextStyle(
              fontSize: context.sp(14),
              color: AppColors.textSecondary,
            ),
          ),
          const SizedBox(height: 5),
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
                  Icons.check_circle,
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
          const SizedBox(height: 20),
          for (final profileTab in profileTabs) profileTab,
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              padding: EdgeInsets.symmetric(vertical: context.h(10)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.logout_outlined, size: context.w(20)),
                const SizedBox(width: 10),
                Text(
                  'Log out',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: context.sp(15),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
