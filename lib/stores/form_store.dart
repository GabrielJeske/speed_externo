import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';
import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';

part 'form_store.g.dart';


class FormStore =_FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store{
     
   @observable
   ObservableMap<String, String> formValues = ObservableMap.of({});


   @observable
   ObservableMap<String, String?> formErrors = ObservableMap.of({
   });

   @computed
   bool get isFormValid => formErrors.values.every((error) => error == null);


   @action
   void setField(String chave, String value){
      formValues[chave]=value;
      validateField(chave, value);
   }

   @action
   void resetForm() {
      formValues.clear(); 
      formErrors.clear(); 
   }
   
   @action
   void validateField(String chave, String value) {
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
  void validateAllFields(String tipo) {
    final Map<String, String> fieldsToValidate = Map.from(formValues); // Cópia para evitar modificação durante a iteração

      if (tipo == 'ps'){
        validateField('nome', fieldsToValidate['nome'] ?? '');
        validateField('cpf', fieldsToValidate['cpf'] ?? '');
        validateAll();
      }else if (tipo == 'pj'){
        validateField('razaosocial', fieldsToValidate['razaosocial'] ?? '');
        validateField('cnpj', fieldsToValidate['cnpj'] ?? '');
        validateField('fantasia', fieldsToValidate['fantasia'] ?? '');
        validateAll();
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

  Future<File> obtemFileClie() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final path = dir.path;
      final f = File('$path/clientes.json');
      bool fExiste = await f.exists();
      if (fExiste) {
        return f;
      } else {
        List<Map<String, dynamic>> mClientes = [];
        final jClientes = jsonEncode(mClientes);
        await f.writeAsString(jClientes);
        return f;
      }
    } catch (e) {
      log('Erro em obtemFileClie: $e');
      rethrow; // Ou retorne null, ou trate conforme apropriado para seu aplicativo
    }
  }

  Future<int> obtemId() async {
    try {
      final json = await obtemFileClie();
      final contJson = await json.readAsString();
      final dynamic decodedJson = jsonDecode(contJson);

      List<Map<String, dynamic>> listaDeClientes = [];

      if (decodedJson is List) {
        listaDeClientes = decodedJson.cast<Map<String, dynamic>>().toList();
      } else if (decodedJson is Map) {
        listaDeClientes.add(decodedJson.cast<String, dynamic>());
      } else {
        log('Estrutura JSON inesperada em obtemId');
        return 1; // Ou lance uma exceção, ou trate de forma diferente
      }

      if (listaDeClientes.isNotEmpty) {
        final ultimoCliente = listaDeClientes.last;
        if (ultimoCliente.containsKey('id') && ultimoCliente['id'] is String) {
          try {
            int ultimoID = int.parse(ultimoCliente['id']);
            return ultimoID + 1;
          } catch (e) {
            log('Erro ao analisar o id em obtemId: $e');
            return 1; // Ou lance uma exceção, ou trate de forma diferente
          }
        } else {
          log('Último cliente não tem um id válido em obtemId');
          return 1; // Ou lance uma exceção
        }
      } else {
        return 1;
      }
    } catch (e) {
      log('Erro em obtemId: $e');
      return 1; // Ou lance uma exceção
    }
  }

  Future<void> salvaCliente() async {
    try {
      final int id = await obtemId();
      final fCliente = await obtemFileClie();
      final String contJson = await fCliente.readAsString();
      final dynamic decodedJson = jsonDecode(contJson);

      List<Map<String, dynamic>> clientes = [];
      if (decodedJson is List) {
        clientes = decodedJson.cast<Map<String, dynamic>>().toList();
      } else if (decodedJson is Map) {
        clientes.add(decodedJson.cast<String, dynamic>());
      }

      if (formValues.isNotEmpty) {
        final Map<String, String> cliente = Map<String, String>.from(formValues); // Use Map.from
        cliente['id'] = '$id'; // Linha corrigida
        clientes.add(Map<String, dynamic>.from(cliente)); // Adiciona como mapa dinâmico
        await fCliente.writeAsString(jsonEncode(clientes)); // Escreve de volta no arquivo
        log('Cliente salvo: $clientes');
      } else {
        log('Valores vazios em salvaCliente');
      }
    } catch (e) {
      log('Erro em salvaCliente: $e');
      rethrow; // Ou trate o erro como apropriado
    }
  }

  
}