import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/providers/language_provider.dart';
import 'package:ok_ok/utils/responsive.dart';
import 'package:ok_ok/widgets/common/screen_padding.dart';

class FilterDestination extends ConsumerStatefulWidget {
  const FilterDestination({
    super.key,
    required this.destinationEnd,
    required this.destinationStart,
  });

  final String destinationStart;
  final String destinationEnd;

  @override
  ConsumerState<FilterDestination> createState() => _FilterDestinationState();
}

class _FilterDestinationState extends ConsumerState<FilterDestination> {
  final _formKey = GlobalKey<FormState>();
  var _destinationStart = '';
  var _destinationEnd = '';

  @override
  Widget build(BuildContext context) {
    final lang = ref.read(languageProvider.notifier);
    return ScreenPadding(
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              initialValue: widget.destinationStart,
              decoration: InputDecoration(
                label: Text(
                  lang.translate('inputStartLocation'),
                  style: TextStyle(
                    fontSize: context.sp(14),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.place_outlined,
                  size: context.w(20),
                  color: AppColors.primary,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(15),
                  vertical: context.h(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) {
                _destinationStart = value!;
              },
            ),
            const SizedBox(height: 20),
            TextFormField(
              initialValue: widget.destinationEnd,
              decoration: InputDecoration(
                label: Text(
                  lang.translate('inputEndLocation'),
                  style: TextStyle(
                    fontSize: context.sp(14),
                    color: AppColors.textSecondary,
                  ),
                ),
                prefixIcon: Icon(
                  Icons.place_outlined,
                  size: context.w(20),
                  color: AppColors.primary,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: context.w(15),
                  vertical: context.h(12),
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return lang.translate('inputNullError');
                }
                return null;
              },
              onSaved: (value) {
                _destinationEnd = value!;
              },
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {},
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
      ),
    );
  }
}
