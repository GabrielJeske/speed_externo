import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/pedidoForm_store.dart';

part 'dadosPedido_store.g.dart';


class DadosPedidoStore =_DadosPedidoStoreBase with _$DadosPedidoStore;

abstract class _DadosPedidoStoreBase with Store{

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  @observable
  ObservableList<Cliente> listaClientes = ObservableList<Cliente> ();

  @observable
  String filtro = '';

  @observable
  Cliente clienSele = Cliente();
  
  @action
  void addProd(Produto prod){
    listaProdutos.add(prod);  
  }

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
    return listaClientes.toList();
  } else {
    return listaClientes.where((cliente) {
  
      final String nomeCliente = cliente.nome?.toString().toLowerCase() ?? '';
      final String razaoSocialCliente = cliente.razaosocial?.toString().toLowerCase() ?? '';
      final String fantasiaCliente = cliente.fantasia?.toString().toLowerCase() ?? '';

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
  
  final pedidoStore = Get.find<PedidoStore>();

  clienSele = clienteSelecionado;
  log('Cliente Selecionado $clienSele e $clienteSelecionado');

  pedidoStore.resetForm();

  pedidoStore.controllerCliente.text = clienteSelecionado.nome.toString();   
  
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




}

