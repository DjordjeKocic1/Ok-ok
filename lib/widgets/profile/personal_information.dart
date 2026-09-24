import 'package:flutter/material.dart';
import 'package:ok_ok/data/service_data.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';
import 'package:ok_ok/widgets/profile/editable_info_tile.dart';

class PersonalInformation extends StatefulWidget {
  const PersonalInformation({super.key});

  @override
  State<PersonalInformation> createState() => _PersonalInformationState();
}

class _PersonalInformationState extends State<PersonalInformation> {
  @override
  Widget build(BuildContext context) {
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
                child: Icon(
                  Icons.person_outline_outlined,
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
                      'Personal information',
                      style: TextStyle(
                        fontSize: context.sp(14),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'View and manage your personal details.',
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
          EditableInfoTile(
            name: 'firstName',
            label: 'Full name',
            initialValue: serviceData[0].firstName,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(12),
              topRight: Radius.circular(12),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ne može da bude prazno';
              }
              return null;
            },
          ),
          EditableInfoTile(
            name: 'email',
            label: 'Email',
            initialValue: serviceData[0].email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ne može da bude prazno';
              }
              return null;
            },
          ),
          EditableInfoTile(
            name: 'phone',
            label: 'Phone number',
            initialValue: serviceData[1].phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Ne može da bude prazno';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
