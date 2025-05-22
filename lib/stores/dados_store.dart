import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/stores/form_store.dart';

part 'dados_store.g.dart';


class DadosStore =_DadosStoreBase with _$DadosStore;

abstract class _DadosStoreBase with Store{

  

  @observable
  ObservableList<Map<String, dynamic>> listaClientes = ObservableList<Map<String, dynamic>> ();

  @observable
  String filtro = '';

  @observable
  Map<String, dynamic> clienSele = {}; 

  @action
  Future obtemClientes () async{
    Cliente clienteJson = Cliente();
    try{
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();
      List<Map<String, dynamic>> clientes = clienteJson.deserializaJson(contJson);
      listaClientes = ObservableList<Map<String, dynamic>>.of(clientes);
    }catch (e){
      log('Erro ao obter os clientes');
      rethrow;
    }
  }

  @action
  void setFiltro(String filter){
    filtro = filter;
  }

  @action
  void setCliente(Map<String, dynamic> cliente){
    clienSele = cliente;
  }

  @computed
  List<Map<String, dynamic>> get listaFiltrada {
    if (filtro.isEmpty){
      return listaClientes;
    }else {
      return listaClientes.where((cliente) {
        final nomeCliente = cliente['nome']?.toString().toLowerCase() ?? '';
        final filtroLower = filtro.toLowerCase();
        return nomeCliente.contains(filtroLower);
      }).toList();
    }
  }

  @observable
bool showSuggestions = false;

@action
void setShowSuggestions(bool value) {
  showSuggestions = value;
}

@action
void selecionarCliente(Map<String, dynamic> clienteSelecionado) {
  
  final formStore = Get.find<FormStore>();

  clienSele = clienteSelecionado;
  log('Cliente Selecionado $clienSele e $clienteSelecionado');

  formStore.resetForm();

  clienteSelecionado.forEach((key, value) {
  formStore.controllerNome.text = clienteSelecionado['nome']?.toString() ?? '';
  formStore.controllerCpf.text = clienteSelecionado['cpf']?.toString() ?? '';
  formStore.controllerIe.text = clienteSelecionado['ie']?.toString() ?? '';
  formStore.controllerEndereco.text = clienteSelecionado['endereco']?.toString() ?? '';
  formStore.controllerNumero.text = clienteSelecionado['n']?.toString() ?? ''; // Assumindo 'n' para o número do endereço
  formStore.controllerBairro.text = clienteSelecionado['bairro']?.toString() ?? '';
  formStore.controllerCep.text = clienteSelecionado['cep'];
  formStore.controllerEmail.text = clienteSelecionado['email']?.toString() ?? '';
  formStore.controllerContato.text = clienteSelecionado['contato']?.toString() ?? '';
  formStore.controllerNumeroContato.text = clienteSelecionado['numero']?.toString() ?? '';
  });
}

  Future<File> obtemFileClie() async{
    try {
      Directory dir = await getApplicationDocumentsDirectory();              
        String path =  dir.path;        
        File f = File('$path/cliente05.json');        
        bool fExiste = await f.exists();        
        if (fExiste){
          return f;
        }else {
          List<Map<String, dynamic>> mapClientes = [];
          final jClientes = jsonEncode(mapClientes);
          await f.writeAsString(jClientes);
          return f;
        }
    } catch (e) {
      log('erro ao obter Arquivo de clientes $e');
      rethrow;
    }      
  }

  Future<int> obtemId() async{
    Cliente clienteJson = Cliente();
    try {      
      File json = await obtemFileClie();
      String contJson = await json.readAsString();
      if (contJson != '[]' ){
        List<Map<String, dynamic>> listaDeClientes = clienteJson.deserializaJson(contJson);        
        Map<String, dynamic> ultimoCliente = listaDeClientes.last;        
        int ultimoID = ultimoCliente['id'];
        ultimoID++;
        return ultimoID;
      }else {
        return 1;
      }
    }catch (e) {
      log('Erro ao obter o id $e');
      rethrow;
    }
        
  }

  salvaCliente() async{
    Cliente clienteJson = Cliente();
    final formStore = Get.find<FormStore>();
    try{
      int id = await obtemId();
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();           
      List<Map<String, dynamic>> clientes = clienteJson.deserializaJson(contJson);
      final cliente = <String, dynamic>{};
      formStore.formValues.forEach((key, value) {
        cliente[key] = value;
      });
      cliente["id"]=id;
      clientes.add(cliente);
      final jClientes = jsonEncode(clientes);
      await fCliente.writeAsString(jClientes);  
      log('Salvou porraa $clientes');
    }catch (e){
      log('Erro ao salvar o cliente $e');
      rethrow;
    }
  }


}

