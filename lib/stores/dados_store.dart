import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
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
  void obtemClientes () async{
    try{
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();
      List<Map<String, dynamic>> clientes = jsonDecode(contJson).cast<Map<String, dynamic>>();
      listaClientes = ObservableList<Map<String, dynamic>>.of(clientes);
    }catch (e){
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
      return listaClientes.where((cliente) => cliente['nome']?.contains(filtro)).toList();
    }
  }



  Future<File> obtemFileClie() async{
    try {
      Directory dir = await getApplicationDocumentsDirectory();      
        log('Obtem DIR $dir');
        String path =  dir.path;
        log('Obtem path $path');
        File f = File('$path/cliente05.json');
        log('DEfini file $f');
        bool fExiste = await f.exists();
        log('verifica se existe file $fExiste');
        if (fExiste){
          log('Encontrou o arquivo e vai retornar $f');
          return f;
        }else {
          log('Arquivo não encontrado, vai criar');
          List<Map<String, dynamic>> mapClientes = [];
          final jClientes = jsonEncode(mapClientes);
          await f.writeAsString(jClientes);
          log('Criou o arquivo e vai retornar $f');
          return f;
        }
    } catch (f) {
      log('erro ao obter Arquivo de clientes $f');
      rethrow;
    }      
  }

  Future<int> obtemId() async{
    try {
      log('Vai obter o ID');
      File json = await obtemFileClie();
      log('Objet o json $json');
      String contJson = await json.readAsString();
      log('Passou o Json para a String $contJson');
      if (contJson != '[]' ){
        List<Map<String, dynamic>> listaDeClientes = jsonDecode(contJson).cast<Map<String, dynamic>>();
        log('ultimo cliente');
        Map<String, dynamic> ultimoCliente = listaDeClientes.last;
        log('ultimo cliente final ');
        int ultimoID = ultimoCliente['id'];
        ultimoID++;
        return ultimoID;
      }else {
        return 1;
      }
    }catch (e) {
      log('Erro ao obter o id');
      rethrow;
    }
        
  }

  salvaCliente() async{
    final formStore = Get.find<FormStore>();
    try{
      int id = await obtemId();
      final fCliente = await obtemFileClie();
      String contJson = await fCliente.readAsString();
      if (contJson != '[]' ){
        List<Map<String, dynamic>> clientes = jsonDecode(contJson).cast<Map<String, dynamic>>();
        final cliente = <String, dynamic>{};
        formStore.formValues.forEach((key, value) {
          cliente[key] = value;
        });
        cliente["id"]=id;
        clientes.add(cliente);
        final jClientes = jsonEncode(clientes);
        await fCliente.writeAsString(jClientes);  
        log('Salvou porraa $clientes');
      }else {
        final cliente = <String, dynamic>{};
        formStore.formValues.forEach((key, value) {
          cliente[key] = value;
        });
        cliente["id"]=id;
        List<Map<String, dynamic>> clientes = [];      
        clientes.add(cliente);
        log('Salvou porraa $clientes');
        final jClientes = jsonEncode(clientes);
        await fCliente.writeAsString(jClientes);
      }
    }catch (e){
      rethrow;
    }
  }


}

