import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';

class FilterModal extends StatefulWidget {
  const FilterModal({super.key});

  @override
  State<FilterModal> createState() => _FilterModalState();
}

class _FilterModalState extends State<FilterModal> {
  final ratings = [4.5, 4.0, 3.5];
  double? _selectedRating;

  final _destinationStartController = TextEditingController();
  final _destinationEndController = TextEditingController();
  final _maxCostController = TextEditingController();

  @override
  void dispose() {
    _destinationStartController.dispose();
    _destinationEndController.dispose();
    _maxCostController.dispose();
    super.dispose();
  }

  void _resetFilters() {
    setState(() {
      _destinationStartController.clear();
      _destinationEndController.clear();
      _maxCostController.clear();
      _selectedRating = null;
    });
  }

  void _applyFilters() {
    Navigator.pop(context, {
      'destinationStart': _destinationStartController.text,
      'destinationEnd': _destinationEndController.text,
      'maxCost': _maxCostController.text,
      'minRating': _selectedRating,
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Filteri', style: TextStyle(fontSize: context.sp(16))),
            const SizedBox(height: 20),
            Text(
              'Polazna lokacija:',
              style: TextStyle(
                fontSize: context.sp(12),
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _destinationStartController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin),
                hintText: 'Belgrade, Serbia',
                hintStyle: TextStyle(color: AppColors.border),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Odrediste:',
              style: TextStyle(
                fontSize: context.sp(12),
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _destinationEndController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_pin),
                hintText: 'Rotterdam, Netherlands',
                hintStyle: TextStyle(color: AppColors.border),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Maksimalna cena po paketu:',
              style: TextStyle(
                fontSize: context.sp(12),
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _maxCostController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.attach_money_outlined),
                hintText: '€5',
                hintStyle: TextStyle(color: AppColors.border),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Minimalna ocena prevoznika:',
              style: TextStyle(
                fontSize: context.sp(12),
                color: AppColors.textSecondary,
              ),
            ),
            Row(
              children: ratings.map((rating) {
                final isSelected = _selectedRating == rating;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.star_border,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text('$rating+'),
                      ],
                    ),
                    selected: isSelected,
                    onSelected: (_) {
                      setState(() {
                        _selectedRating = rating;
                      });
                    },
                    showCheckmark: false,
                    backgroundColor: Colors.white,
                    side: BorderSide(
                      color: isSelected ? AppColors.primary : AppColors.border,
                    ),
                    labelStyle: TextStyle(
                      color: AppColors.textSecondary,
                      fontWeight: isSelected
                          ? FontWeight.w600
                          : FontWeight.normal,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _resetFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.background,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                      side: BorderSide(color: AppColors.border, width: 1),
                    ),
                    child: Text(
                      'Ponisti',
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontSize: context.sp(14),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 10,
                      ),
                      minimumSize: Size.zero,
                    ),
                    child: Text(
                      'Primeni',
                      style: TextStyle(fontSize: context.sp(14)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
