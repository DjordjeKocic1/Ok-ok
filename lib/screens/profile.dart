import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/modal/enums.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/profile/language.dart';
import 'package:ok_ok/widgets/profile/password.dart';
import 'package:ok_ok/widgets/profile/personal_information.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  ProfileTab? _selectedTab;

  void _openProfileTab() {
    Widget tab = const SizedBox.shrink();

    switch (_selectedTab) {
      case ProfileTab.personal:
        tab = PersonalInformation();
        break;
      case ProfileTab.password:
        tab = Password();
        break;
      case ProfileTab.language:
        tab = Language();
        break;
      case ProfileTab.help:
        tab = const Text('TODO: Help & Support');
        break;
      case ProfileTab.about:
        tab = const Text('TODO: About OKOK');
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
                    Text(title, style: TextStyle(fontSize: context.sp(14))),
                    Text(
                      subTitle,
                      style: TextStyle(
                        fontSize: context.sp(12),
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
    final profileTabs = <Widget>[
      _profileTab(
        Icons.person_outline_outlined,
        'Personal information',
        'Personal information',
        ProfileTab.personal,
      ),
      _profileTab(
        Icons.admin_panel_settings_outlined,
        'Security',
        'Password',
        ProfileTab.password,
      ),
      _profileTab(
        Icons.language_outlined,
        'Language',
        'Change app language',
        ProfileTab.language,
      ),
      _profileTab(
        Icons.support_outlined,
        'Help & Support',
        'Contact us, FAQs',
        ProfileTab.help,
      ),
      _profileTab(
        Icons.info_outlined,
        'About OKOK',
        'Terms, Privacy Policy',
        ProfileTab.about,
      ),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            serviceData[0].firstName,
            style: TextStyle(
              fontSize: context.sp(16),
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            serviceData[0].email,
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
                    fontSize: context.sp(14),
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
