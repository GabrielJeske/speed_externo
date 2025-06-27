import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/cliente_controller.dart';

part 'validate_store.g.dart';


class ValidateStore =_ValidateStoreBase with _$ValidateStore;

abstract class _ValidateStoreBase with Store{


   @action
   void validateField(String chave, String value) {
    
    final formStore = Get.find<FormStore>();

    formStore.cliente ;

    if (chave == 'email' || chave == 'email' ){
      formStore.formErrors[chave] = _validateEmail(value);
    }else if (chave == 'cpf' ){
      formStore.formErrors[chave] = _validateCpf(value);
    }else if (chave == 'cnpj'){
      formStore.formErrors[chave] = _validateCnpj(value);    
    }else{
      formStore.formErrors[chave] = value.isEmpty ? 'Campo obrigatório' : null;
    }
   }
   

   String? _validateEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    if (email.isEmpty) return 'E-mail é obrigatório';
    if (!emailRegex.hasMatch(email)) return 'E-mail inválido';
    return null;
   }

    String? _validateCpf(String cpf) {
      final RegExp cpfRegex = RegExp(r'^\d{3}\.?\d{3}\.?\d{3}-?\d{2}$');
      if (cpf.isEmpty) return 'CPF é obrigatório';
      if (!cpfRegex.hasMatch(cpf)) return 'CPF inválido';  
      return null;
   }   

   String? _validateCnpj(String cpf) {
      final RegExp cpfRegex = RegExp(r'^\d{2}\.?\d{3}\.?\d{3}/?\d{4}-?\d{2}$');
      if (cpf.isEmpty) return 'CNPJ é obrigatório';
      if (!cpfRegex.hasMatch(cpf)) return 'CNPJ inválido';  
      return null;
   }   

   @action
  void validateAllFields(String tipo) {

    final formStore = Get.find<FormStore>();


    final  fieldsToValidate = (formStore.cliente);
  
    log('Chgou no  ValidadeAll e obetve os dados $fieldsToValidate');

      if (tipo == 'pf'){
        validateField('email', fieldsToValidate.email ?? '');
        validateField('endereco', fieldsToValidate.endereco ?? '');
        validateField('cep', fieldsToValidate.cep ?? '');
        validateField('contato', fieldsToValidate.contato ?? '');
        validateField('numero', fieldsToValidate.numeroContato ?? '');
        validateField('contribuinte', fieldsToValidate.contribuinte ?? '');
        validateField('ie', fieldsToValidate.ie ?? '');     
      }else if (tipo == 'pj'){
        validateField('razaosocial', fieldsToValidate.razaosocial ?? '');
        validateField('cnpj', fieldsToValidate.cnpj ?? '');
        validateField('fantasia', fieldsToValidate.fantasia ?? '');     
        validateField('email', fieldsToValidate.email ?? '');
        validateField('endereco', fieldsToValidate.endereco ?? '');
        validateField('cep', fieldsToValidate.cep ?? '');
        validateField('contato', fieldsToValidate.contato ?? '');
        validateField('numero', fieldsToValidate.numeroContato ?? '');
        validateField('contribuinte', fieldsToValidate.contribuinte ?? '');
        validateField('ie', fieldsToValidate.ie ?? '');         
      }
      
          
  }

}
