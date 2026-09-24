import 'package:flutter/material.dart';
import 'package:ok_ok/main.dart';
import 'package:ok_ok/utils/responsive.dart';

class EditableInfoTile extends StatefulWidget {
  const EditableInfoTile({
    super.key,
    required this.name,
    required this.label,
    required this.initialValue,
    this.borderRadius,
    required this.validator,
  });

  final String name;
  final String label;
  final String initialValue;
  final BorderRadius? borderRadius;
  final String? Function(String?)? validator;

  @override
  State<EditableInfoTile> createState() => _EditableInfoTileState();
}

class _EditableInfoTileState extends State<EditableInfoTile> {
  final _formKey = GlobalKey<FormState>();
  var _formValue = '';
  var _isEditing = false;

  void _handleTap() {
    if (_isEditing) {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        print({widget.name: _formValue});
        setState(() => _isEditing = false);
      }
    } else {
      setState(() => _isEditing = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.background,
        borderRadius: widget.borderRadius,
        border: Border.all(color: AppColors.border),
      ),
      child: Form(
        key: _formKey,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!_isEditing)
                    Text(
                      widget.label,
                      style: TextStyle(
                        fontSize: context.sp(12),
                        color: AppColors.textSecondary,
                      ),
                    ),

                  const SizedBox(height: 2),
                  if (!_isEditing)
                    Text(
                      widget.initialValue.isEmpty ? '-' : widget.initialValue,
                      style: TextStyle(fontSize: context.sp(12)),
                    ),
                  if (_isEditing)
                    TextFormField(
                      decoration: InputDecoration(
                        label: Text(
                          widget.label,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: context.sp(12),
                          ),
                        ),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 5,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(color: AppColors.border),
                        ),
                      ),
                      initialValue: widget.initialValue,
                      validator: widget.validator,
                      onSaved: (newValue) {
                        _formValue = newValue!;
                      },
                    ),
                ],
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.all(6),
              decoration: const BoxDecoration(
                color: AppColors.mainColor,
                shape: BoxShape.circle,
              ),
              child: GestureDetector(
                onTap: _handleTap,
                child: Icon(
                  _isEditing ? Icons.done_outlined : Icons.edit_outlined,
                  color: AppColors.primary,
                  size: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
