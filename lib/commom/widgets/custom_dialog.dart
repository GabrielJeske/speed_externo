import 'package:flutter/material.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Inclusão de produtos'),
      content: Column(
        children: [
          CustomFormField(
            labelText:'Produto')
        ],
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.of(context).pop();
        },
         child: Text('Sair')
        )
      ],
    );
  }
}