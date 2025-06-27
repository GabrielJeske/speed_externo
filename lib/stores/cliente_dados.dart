import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/stores/cliente_controller.dart';
import 'package:http/http.dart' as http; 
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
    try{
      String jsonResp = await obtemJsonClientes();

       List<Cliente> clientes = obtemCliente(jsonResp); // Passe a string JSON original ou a lista decodificada, dependendo da sua implementação de Cliente.obtemClientes

        listaClientes = ObservableList<Cliente>.of(clientes);

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
  
      final String razaoSocialCliente = cliente.razaosocial?.toString().toLowerCase() ?? '';

      // Obtém e normaliza o nome fantasia (para PJ)
      final String fantasiaCliente = cliente.fantasia?.toString().toLowerCase() ?? '';

      // Verifica se o filtroLower está contido em qualquer um dos campos
      bool filtrado = razaoSocialCliente.contains(filtro.toLowerCase()) ||
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

    formStore.controllerRazao.text = clienteSelecionado.razaosocial.toString();
    formStore.controllerFantasia.text = clienteSelecionado.fantasia.toString();
    formStore.controllerCnpj.text = clienteSelecionado.cnpj.toString();
  formStore.controllerIe.text = clienteSelecionado.ie.toString();
  formStore.controllerEndereco.text = clienteSelecionado.endereco.toString();
  formStore.controllerCep.text = clienteSelecionado.cep.toString();
  formStore.controllerEmail.text = clienteSelecionado.email.toString();
  formStore.controllerContato.text = clienteSelecionado.contato.toString();
} 

  List<Cliente> obtemCliente(String jsonString){    
    List<dynamic> listaGenerica= jsonDecode(jsonString);
    List<Cliente> clientes = [];
    for (Map<String, dynamic> a in listaGenerica) {   
      Cliente cliente = Cliente.fromJson(a);
      clientes.add(cliente);
    }
     return clientes; 
    }
    
   Future<String> obtemJsonClientes() async{

    Uri urlClientes = Uri.parse("https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/name");

    try {
      log('Obtendo pedidos de $urlClientes ${DateTime.now().toIso8601String()}');
      http.Response  resp = await http.get(urlClientes);
      log('Resposta obtida ${DateTime.now().toIso8601String()}');
      if (resp.statusCode == 200) {
        return resp.body;
      } else {
        throw Exception('Falha ao obter pedidos');
      }
    } catch (e) {
      log('erro ao obter Arquivo de pedidos $e');
      rethrow;
    }      
  }

  Future<File> obtemFileClie() async{
    try {
      Directory dir = await getApplicationDocumentsDirectory();              
        String path =  dir.path;        
        File f = File('$path/clientes.json');        
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
    try {      
      File json = await obtemFileClie();
      String contJson = await json.readAsString();
      if (contJson != '[]' ){
        List<Cliente> listaDeClientes = obtemCliente(contJson);
        int id = 0;        
        for (Cliente cliente in listaDeClientes){          
          int a = int.parse(cliente.id ?? '0' );
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
      log('Obteve o id $id');
      final fCliente = await obtemFileClie();
      log('Obteve o arquivo de clientes $fCliente');
      String contJson = await fCliente.readAsString();           
      log('Obsete o conteudo do arquiv $contJson');
      List<Cliente> clientes = obtemCliente(contJson);
      log('Criou a lista de cliente $clientes');
      formStore.cliente.id=id.toString();
      log('Atribui o id ');
      clientes.add(formStore.cliente);
      final jClientes = jsonEncode(clientes);
      await fCliente.writeAsString(jClientes);  
      log('Salvou porraa $clientes');
    }catch (e){
      throw 'Erro ao salvar o cliente $e';
    }
  }



}

