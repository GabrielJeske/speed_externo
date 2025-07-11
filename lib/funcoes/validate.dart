import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/stores/cliente_controller.dart';

 class Validate {


   
   void validateField(String chave, String value) {
    
    final dadosCliente = Get.find<ClienteController>();

    if (chave == email ){
      dadosCliente.formErrors[chave] = validateEmail(value);
    }else if (chave == cnpj){
      dadosCliente.formErrors[chave] = validateDocumento(value);
    }else if (chave == ie){   
      if (dadosCliente.cliente.contribuinte == '1'){
        dadosCliente.formErrors[chave] = validateIe(value);
        log('tentou validar ${dadosCliente.cliente.contribuinte}');
      }
    }else{
      dadosCliente.formErrors[chave] = value.isEmpty ? 'Campo obrigatório' : null;
    }

   }
   
   String? validateDocumento(String doc){
    if (doc.isEmpty) return 'Campo obrigatorio';
    log(' a $doc');
    doc = doc.replaceAll(RegExp(r'[^\d]'), '');
    log('b $doc');
    if (doc.length == 11) {
       if (RegExp(r'^(\d)\1*$').hasMatch(doc)) {
        return 'CPF inválido';
      }
      //-- Cálculo do 1º Dígito Verificador --//
      int soma = 0;
      for (int i = 0; i < 9; i++) {
        soma += int.parse(doc[i]) * (10 - i);
      }
      int primeiroDigito = 11 - (soma % 11);
      if (primeiroDigito >= 10) {
        primeiroDigito = 0;
      }

      // Verifica o 1º dígito
      if (int.parse(doc[9]) != primeiroDigito) {
        return 'CPF inválido';
      }

      //-- Cálculo do 2º Dígito Verificador --//
      soma = 0;
      for (int i = 0; i < 10; i++) {
        soma += int.parse(doc[i]) * (11 - i);
      }
      int segundoDigito = 11 - (soma % 11);
      if (segundoDigito >= 10) {
        segundoDigito = 0;
      }

      // Verifica o 2º dígito
      if (int.parse(doc[10]) != segundoDigito) {
        return 'CPF inválido';
      }
    }else if (doc.length == 14){
      if (RegExp(r'^(\d)\1*$').hasMatch(doc)) {
        return 'CNPJ inválido';
      }
      // Pesos para o cálculo dos dígitos verificadores
      final List<int> pesos1 = [5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];
      final List<int> pesos2 = [6, 5, 4, 3, 2, 9, 8, 7, 6, 5, 4, 3, 2];

      //-- Cálculo do 1º Dígito Verificador --//
      int soma = 0;
      for (int i = 0; i < 12; i++) {
        soma += int.parse(doc[i]) * pesos1[i];
      }
      int primeiroDigito = 11 - (soma % 11);
      if (primeiroDigito < 2) {
        primeiroDigito = 0;
      }
      
      // Verifica o 1º dígito
      if (int.parse(doc[12]) != primeiroDigito) {
        return 'CNPJ inválido';
      }

      //-- Cálculo do 2º Dígito Verificador --//
      soma = 0;
      for (int i = 0; i < 13; i++) {
        soma += int.parse(doc[i]) * pesos2[i];
      }
      int segundoDigito = 11 - (soma % 11);
      if (segundoDigito < 2) {
        segundoDigito = 0;
      }

      // Verifica o 2º dígito
      if (int.parse(doc[13]) != segundoDigito) {
        return 'CNPJ inválido';
      }
    }else {
      return 'Documento invalido';
    }
   }

   String? validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (email.isEmpty) return 'E-mail é obrigatório';
    if (!emailRegex.hasMatch(email)) return 'E-mail inválido';
    return null;
   }

   String? validateIe(String ie) {
    if (ie.isEmpty) return 'Ie é obrigatória';
    return null;
   }


  void validateAllFields() {

    final clienteController = Get.find<ClienteController>();


  
    validateField(razaosocial, clienteController.cliente.razaosocial ?? '');
    validateField(cnpj, clienteController.cliente.cnpj ?? '');
    validateField(endereco, clienteController.cliente.endereco ?? '');
    validateField(cep, clienteController.cliente.cep ?? '');
    validateField(ie, clienteController.cliente.cep ?? '');
    log('valor de ${clienteController.formErrors[contribuinte]}');
    validateField(contribuinte, clienteController.cliente.contribuinte ?? '');

                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
  }

}
