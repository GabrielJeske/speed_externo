// lib/pages/login.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_externo/commom/widgets/custom_buttom.dart';
import 'package:speed_externo/commom/widgets/custom_appbar.dart';
import 'package:speed_externo/commom/widgets/custom_textField.dart';
import 'package:speed_externo/funcoes/autentica.dart';


class LoginPage extends StatelessWidget {

  LoginPage({super.key});

  final autentica = Get.find<Autentica>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: CustomAppBar(title: 'Login'),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Expanded(
                  child: CustomFormField(labelText: 'Login',
                  onChanged: (value) => autentica.setField(value, 'login'),),
                ),
              ],
            ),          
            const SizedBox(height: 20), 
            Row(
              children: [
                Expanded(
                  child: CustomFormField(
                    labelText: 'Senha',
                    onChanged: (value) => autentica.setField(value, 'senha'),
                    ),
                )
              ],
            ),
            SizedBox(height: 30,),
            Row(
              children: [
                Expanded(
                  child: 
                    
            CustomButtom(
            onPressed: () {
              autentica.fazLogin();
            },
              label: Text('Entrar'),            
            ),
              
            )  
              ],
            )
             
          ],
        ),
      ),
    );
  }
}