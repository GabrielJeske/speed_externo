 
import 'package:flutter/material.dart';

class CustomButtom extends StatelessWidget {
  dynamic label;
  VoidCallback onPressed; 
  
  CustomButtom({
    Key? key,
    required this.label,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              padding: EdgeInsets.all(15),
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              textStyle: TextStyle(fontSize: 20)
      ),
      child: label,
    );
  }
}