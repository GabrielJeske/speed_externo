import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/stores/cliente_controller.dart';

part 'cliente_dados.g.dart';


class DadosStore =_DadosStoreBase with _$DadosStore;

abstract class _DadosStoreBase with Store{

  

  @observable
  ObservableList<Cliente> listaClientes = ObservableList<Cliente> ();

  @observable
  String filtro = '';

  @observable
  Cliente clienSele = Cliente(); 

  @action
  Future obtemClientes () async{
    Cliente clienteJson = Cliente();
    try{
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();
      List<Cliente> clientes = clienteJson.obtemClientes(contJson);
      listaClientes = ObservableList<Cliente>.of(clientes);
      log('Obteve os clientes $listaClientes');
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
  void setCliente(Cliente cliente){
    clienSele = cliente;
  }

  @computed
List<Cliente> get listaFiltrada {
  if (filtro.isEmpty) {
    // Se não há filtro, retorna todos os clientes.
    // Retornar listaClientes.toList() cria uma nova lista, o que é seguro.
    return listaClientes.toList();
  } else {

    return listaClientes.where((cliente) {
      // Obtém e normaliza o nome do cliente (para PF e PJ)
      final String nomeCliente = cliente.nome?.toString().toLowerCase() ?? '';

      // Obtém e normaliza a razão social (para PJ)
      // Se a chave não existir ou for nula, resultará em string vazia.
      final String razaoSocialCliente = cliente.razaosocial?.toString().toLowerCase() ?? '';

      // Obtém e normaliza o nome fantasia (para PJ)
      final String fantasiaCliente = cliente.fantasia?.toString().toLowerCase() ?? '';

      // Verifica se o filtroLower está contido em qualquer um dos campos
      bool filtrado = nomeCliente.contains(filtro.toLowerCase()) ||
                        razaoSocialCliente.contains(filtro.toLowerCase()) ||
                        fantasiaCliente.contains(filtro.toLowerCase());

      return filtrado;
    }).toList();
  }
}

  @observable
bool exibeListaCliente = false;

@action
void setListaCliente(bool value) {
  exibeListaCliente = value;
}

@action
void selecionarCliente(Cliente clienteSelecionado, String tipo) {
  
  final formStore = Get.find<FormStore>();

  clienSele = clienteSelecionado;
  log('Cliente Selecionado $clienSele e $clienteSelecionado');

  formStore.resetForm();

  if (tipo == 'pf'){
    formStore.controllerNome.text = clienteSelecionado.nome.toString();
    formStore.controllerCpf.text = clienteSelecionado.cpf.toString();
  }else if ( tipo == 'pj'){
    formStore.controllerRazao.text = clienteSelecionado.razaosocial.toString();
    formStore.controllerFantasia.text = clienteSelecionado.fantasia.toString();
    formStore.controllerCnpj.text = clienteSelecionado.cnpj.toString();
  }
  formStore.controllerIe.text = clienteSelecionado.ie.toString();
  formStore.controllerEndereco.text = clienteSelecionado.endereco.toString();
  formStore.controllerNumero.text = clienteSelecionado.endereco.toString(); 
  formStore.controllerBairro.text = clienteSelecionado.bairro.toString();
  formStore.controllerCep.text = clienteSelecionado.cep.toString();
  formStore.controllerEmail.text = clienteSelecionado.email.toString();
  formStore.controllerContato.text = clienteSelecionado.contato.toString();
  formStore.controllerNumeroContato.text = clienteSelecionado.numero.toString();
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
          List<Cliente> mapClientes = [];
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
        List<Cliente> listaDeClientes = clienteJson.obtemClientes(contJson);
        int id = 0;        
        for (Cliente cliente in listaDeClientes){
          int a = int.parse(cliente.id ?? '0');
          if (a > id){
            id = a;
          }    
        }        
        id++;
        return id;
      }else {
        return 1;
      }
    }catch (e) {
      log('Erro ao obter o id $e');
      rethrow;
    }
        
  }

  salvaCliente() async{
    final formStore = Get.find<FormStore>();
    try{
      int id = await obtemId();
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();           
      List<Cliente> clientes = formStore.cliente.obtemClientes(contJson);
      formStore.cliente.id='$id';
      clientes.add(formStore.cliente);
      final jClientes = jsonEncode(clientes);
      await fCliente.writeAsString(jClientes);  
      log('Salvou porraa $clientes');
    }catch (e){
      log('Erro ao salvar o cliente $e');
      rethrow;
    }
  }


}

