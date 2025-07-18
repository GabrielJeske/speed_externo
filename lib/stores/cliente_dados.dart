import 'dart:convert';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:http/http.dart' as http;
import 'package:speed_externo/stores/cliente_controller.dart'; 
import 'package:crypto/crypto.dart';
part 'cliente_dados.g.dart';  


class ClienteDados = ClienteDadosBase with _$ClienteDados;

abstract class ClienteDadosBase with Store{

  @observable
  bool exibeListaCliente = false;

  @observable
  ObservableList<Cliente> listaClientes = ObservableList<Cliente> ();

  @observable
  String filtro = '';

  @observable
  Cliente clienSele = Cliente(); 

  final Box<Cliente> clientesBox = Hive.box<Cliente>('Clientes');

  @action
  void setListaCliente(bool value) {                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
    exibeListaCliente = value;
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
      String razaoSocialCliente = cliente.razaosocial?.toString().toLowerCase() ?? '';
      String fantasiaCliente = cliente.fantasia?.toString().toLowerCase() ?? '';
      bool filtrado = razaoSocialCliente.contains(filtro.toLowerCase()) || fantasiaCliente.contains(filtro.toLowerCase());
      return filtrado;
    }).toList();
  }
}

  void selecionarCliente(Cliente clienteSelecionado) {    
    final formStore = Get.find<ClienteController>();

    clienSele = clienteSelecionado;
    formStore.resetForm();

    formStore.controllerRazao.text = clienteSelecionado.razaosocial.toString();
    formStore.controllerFantasia.text = clienteSelecionado.fantasia.toString();
    formStore.controllerCnpj.text = clienteSelecionado.cnpj.toString();
    formStore.controllerIe.text = clienteSelecionado.ie.toString();
    formStore.controllerEndereco.text = clienteSelecionado.endereco.toString();
    formStore.controllerCep.text = clienteSelecionado.cep.toString();
    formStore.controllerEmail.text = clienteSelecionado.email.toString();
    formStore.controllerContato.text = clienteSelecionado.contato.toString();
    if (clienteSelecionado.contribuinte == 1){
      formStore.contribuitePadrao = contribuinte1; 
    }else if (clienteSelecionado.contribuinte == 2){
      formStore.contribuitePadrao = contribuinte2; 
    }else if (clienteSelecionado.contribuinte == 9){
      formStore.contribuitePadrao = contribuinte9; 
    }  
  } 

  @action
  Future<void> obtemClientes() async {
    try {
      await atualizaClientes();
      final clientes = clientesBox.values.toList();
      listaClientes = ObservableList<Cliente>.of(clientes);
    } catch (e) {
      throw Exception('Erro ao obter clientes: $e');
    }
  }

  Future<void> salvaCliente() async {
    final dadosCliente = Get.find<ClienteController>();
     var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/cliente');
    try {
      String cliente = jsonEncode(dadosCliente.cliente.toJson());
      
      var resposta = await http.post(url, body: 'a');

      if (resposta.statusCode == 200){
      }else {
      }
    } catch (e) {
      throw Exception('Erro ao salvar cliente: $e');
    }
  }

  String geraMd5(String texto) {
    var bytes = utf8.encode(texto);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
  
  Future<void> atualizaClientes() async {
      var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/name');
    try {
//      listaClientes = ObservableList<Cliente> ();
      List<Cliente> clientesLocais = clientesBox.values.toList();
      String corpoJson = jsonEncode(clientesLocais.map((cliente) => cliente.toJson()).toList()); 
      String md5 = geraMd5(corpoJson);

      //var resposta = await http.post(url, headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: md5);
      var resposta = await http.get(url);

      if (resposta.statusCode == 200){
        List<dynamic> listaRecebida = jsonDecode(resposta.body);

        List<Cliente> clientesAtualizados = listaRecebida.map((json) => Cliente.fromJson(json as Map<String, dynamic>)).toList();

        await clientesBox.clear();      
        await clientesBox.putAll(Map.fromEntries(clientesAtualizados.map((cliente) => MapEntry(cliente.id, cliente))));  

      }else if (resposta.statusCode == 404) {
      }else {
      }
    } catch (e) {
      throw Exception('Erro ao atualizar clientes: $e');
    }
  }


}

