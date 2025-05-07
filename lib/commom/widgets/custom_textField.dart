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
  final bool isConsulta;
  final void Function(String)? onFieldSubmitted;
  final void Function()? onEditingComplete;

  const CustomFormField({
    Key? key,
    required this.labelText,
    this.controller,
    this.errorText,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.readOnly = false,
    this.onChanged,
    this.isConsulta = false,
    this.mask,
    this.onFieldSubmitted,
    this.onEditingComplete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        inputFormatters: mask,
        decoration: InputDecoration(
          labelText: labelText,
          errorText: errorText,
          border: const OutlineInputBorder(),
        ),
        keyboardType: keyboardType,
        validator: validator,
        readOnly: readOnly, // Aplica readOnly diretamente
        onChanged: onChanged, // Mantém onChanged sempre
        onFieldSubmitted: onFieldSubmitted,
        onEditingComplete: onEditingComplete,
      ),
    );
  }
}