import 'dart:convert';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'form_store.g.dart';


class FormStore =_FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store{

   @observable
   String tipo = 'pj';
     
   @observable
   ObservableMap<String, String> formValues = ObservableMap.of({});

   @observable
   ObservableMap<String, String?> formErrors = ObservableMap.of({
   });

   @computed
   bool get isFormValid => formErrors.values.every((error) => error == null);

   @action
   void setTipo(String tipo){
    tipo = tipo;
   }

   @action
   void setField(String chave, String value){


      formValues[chave]=value;
      validateField(chave, value);

      formValues = ObservableMap.of(formValues);
      formErrors = ObservableMap.of(formErrors);

   }

   @action
   void resetForm() {
      formValues.clear(); 
      formErrors.clear(); 

   
      formValues = ObservableMap.of({});
      formErrors = ObservableMap.of({});
   }
   
   @action
   void validateField(String chave, String value) {

      if (!formValues.containsKey(chave)) {
      formValues[chave] = '';
      formErrors[chave] = 'erro';

      
      }

      formValues[chave] = value;

      if (chave == 'email'){
         formErrors[chave] = _validateEmail(value);
      }else if (chave == 'cpf'){
         formErrors[chave] = _validateCpf(value);
      }else if (chave == 'cnpj'){
        formErrors[chave] = _validateCnpj(value);    
      }else{
         formErrors[chave] = value.isEmpty ? 'Campo obrigatório' : null;
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
  void validateAllFields() {
    
      if (tipo == 'ps'){
        validateField('nome', formValues['nome'] ?? '');
        validateField('cpf', formValues['cpf'] ?? '');
        validateAll();
      }else {
        validateField('razaosocial', formValues['razaosocial'] ?? '');
        validateField('cnpj', formValues['cnpj'] ?? '');
        validateField('fantasia', formValues['fantasia'] ?? '');
        validateAll();
      }
      
        
  }

  @action
  void validateAll(){
    validateField('email', formValues['email'] ?? '');
      validateField('endereco', formValues['endereco'] ?? '');
      validateField('bairro', formValues['bairro'] ?? '');
      validateField('cep', formValues['cep'] ?? '');
      validateField('n', formValues['n'] ?? '');
      validateField('logadouro', formValues['logadouro'] ?? '');
      validateField('contato', formValues['contato'] ?? '');
      validateField('numero', formValues['numero'] ?? '');
      validateField('contribuinte', formValues['contribuinte'] ?? '');
      validateField('ie', formValues['ie'] ?? '');  
  }

   Future<File> obtemFileClie() async{
      final dir = await getApplicationDocumentsDirectory();
      final path =  dir.path;
      final f = File('$path/clientes.json');
      bool fExiste = await f.exists();
      if (fExiste){
         return f;
      }else {
         final mClientes = <String, String>{};
         final jClientes = jsonEncode(mClientes);
         await f.writeAsString(jClientes);
         return f;
      }
  }

   Future<int> obtemId() async{
      final json = await obtemFileClie();
      final contJson = await json.readAsString();
      final List<dynamic> listaDeClientes = jsonDecode(contJson);
      

      if (listaDeClientes.isNotEmpty){
         final ultimoCliente = listaDeClientes.last as Map<String, String>;
         int ultimoID = ultimoCliente['id'] as int;
         ultimoID++;
         return ultimoID;
      }else {
         return 1;
      }
   }

   Future<void> salvaCliente() async{
      String id = await obtemId() as String;
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();
      List<dynamic> clientes = jsonDecode(contJson); 
      if (formValues.isNotEmpty){
         final cliente = <String, String>{};
            formValues.forEach((key, value) {
            cliente[key] = value;
         });
         cliente[id]=id;
         clientes.add(cliente);
         print('$clientes');
      }else {
         print('Valores vazios');
      }
   }
}