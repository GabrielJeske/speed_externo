import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class CustomFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final String? errorText;
  final mask;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final bool readOnly;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  const CustomFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.onTap,
    this.mask,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child:  Observer(builder: (_) =>
        TextFormField(
          controller: controller,
          inputFormatters: mask,
          decoration: InputDecoration(
            labelText: labelText,
            errorText: errorText,
            border: const OutlineInputBorder(),
          ),
          keyboardType: keyboardType,
          validator: validator,
          readOnly: readOnly,
          onChanged: onChanged,
          onTap: onTap,
        ),
      )
    );
  }
}