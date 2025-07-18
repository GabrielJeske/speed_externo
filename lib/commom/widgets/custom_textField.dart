import 'package:flutter/material.dart';

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
  final void Function()? onTap;
  FocusNode? foco;
  String? prefixText;

  CustomFormField({
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
    this.onTap,
    this.foco,
    this.prefixText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Não precisamos mais da Size diretamente aqui para definir a altura do TextFormField
    return TextFormField(
      controller: controller,
      inputFormatters: mask,
      decoration: InputDecoration(
        prefixText: prefixText,
        labelText: labelText,
        labelStyle: const TextStyle( // Adicionado const para otimização
          fontSize: 15
        ),
        errorText: errorText,
        border: const OutlineInputBorder(),
        // Adicione aqui se desejar um padding vertical mais consistente
        contentPadding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
      ),
      keyboardType: keyboardType,
      validator: validator,
      readOnly: readOnly,
      onChanged: onChanged,
      onTap: onTap,
      focusNode: foco,
      style: const TextStyle(
        fontSize: 16
      ),
    );
  }
}