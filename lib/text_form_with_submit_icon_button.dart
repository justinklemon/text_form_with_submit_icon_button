library text_form_with_submit_icon_button;

import 'package:flutter/material.dart';

final GlobalKey<FormFieldState> _formKey = GlobalKey<FormFieldState>();

class TextFormWithSubmitIconButton extends StatelessWidget {
  final Function(String) onSubmit;
  final InputDecoration decoration;
  final String? Function(String?)? validator;
  final IconData submitIcon;
  final String? initialValue;
  TextFormWithSubmitIconButton({
    super.key,
    required this.onSubmit,
    required this.decoration,
    this.submitIcon = Icons.add,
    this.validator,
    this.initialValue,
  }) : _groupNameController = TextEditingController(text: initialValue);

  final TextEditingController _groupNameController;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextFormField(
            key: _formKey,
            controller: _groupNameController,
            decoration: decoration,
            validator: validator,
            onSaved: (value) {
              if (value == null || value.isEmpty) return;
              onSubmit(value);
              _groupNameController.clear();
            },
          ),
        ),
        IconButton(
          icon: Icon(submitIcon),
          onPressed: () {
            bool isValid = _formKey.currentState?.validate() ?? false;
            if (isValid) {
              _formKey.currentState?.save();
            }
          },
        ),
      ],
    );
  }
}
