import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/form_store.dart';

part 'validate_store.g.dart';


class ValidateStore =_ValidateStoreBase with _$ValidateStore;

abstract class _ValidateStoreBase with Store{


   @action
   void validateField(String chave, String value) {
    
    final formStore = Get.find<FormStore>();

    formStore.formValues[chave] = value;

    if (chave == 'email'){
      formStore.formErrors[chave] = _validateEmail(value);
    }else if (chave == 'cpf'){
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

    final Map<String, String> fieldsToValidate = Map.from(formStore.formValues); // Cópia para evitar modificação durante a iteração

      if (tipo == 'pf'){
        validateField('nome', fieldsToValidate['nome'] ?? '');
        validateField('cpf', fieldsToValidate['cpf'] ?? '');
      }else if (tipo == 'pj'){
        validateField('razaosocial', fieldsToValidate['razaosocial'] ?? '');
        validateField('cnpj', fieldsToValidate['cnpj'] ?? '');
        validateField('fantasia', fieldsToValidate['fantasia'] ?? '');      
      }
      validateField('email', fieldsToValidate['email'] ?? '');
      validateField('endereco', fieldsToValidate['endereco'] ?? '');
      validateField('bairro', fieldsToValidate['bairro'] ?? '');
      validateField('cep', fieldsToValidate['cep'] ?? '');
      validateField('n', fieldsToValidate['n'] ?? '');
      validateField('logadouro', fieldsToValidate['logadouro'] ?? '');
      validateField('contato', fieldsToValidate['contato'] ?? '');
      validateField('numero', fieldsToValidate['numero'] ?? '');
      validateField('contribuinte', fieldsToValidate['contribuinte'] ?? '');
      validateField('ie', fieldsToValidate['ie'] ?? '');     
      validateField('email_pj', fieldsToValidate['email_pj'] ?? '');
      validateField('endereco_pj', fieldsToValidate['endereco_pj'] ?? '');
      validateField('bairro_pj', fieldsToValidate['bairro_pj'] ?? '');
      validateField('cep_pj', fieldsToValidate['cep_pj'] ?? '');
      validateField('n_pj', fieldsToValidate['n_pj'] ?? '');
      validateField('logadouro_pj', fieldsToValidate['logadouro_pj'] ?? '');
      validateField('contato_pj', fieldsToValidate['contato_pj'] ?? '');
      validateField('numero_pj', fieldsToValidate['numero_pj'] ?? '');
      validateField('contribuinte_pj', fieldsToValidate['contribuinte_pj'] ?? '');
      validateField('ie_pj', fieldsToValidate['ie_pj'] ?? '');            
  }

}
