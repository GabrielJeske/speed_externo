import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/produtoForm_store.dart';

part 'dadosProduto_store.g.dart';


class DadosProdutoStore =_DadosProdutoStoreBase with _$DadosProdutoStore;

abstract class _DadosProdutoStoreBase with Store{

  

  @observable
  ObservableList<Map<String, dynamic>> listaProdutos = ObservableList<Map<String, dynamic>> ();

  @observable
  String filtroProd = '';

  @observable
  Map<String, dynamic> prodSele = {}; 

  @action
  Future obtemProdutos () async{
    Produto produtoJson = Produto();
    try{
      final fProduto = await obtemFileProd();
      String contJson = await fProduto.readAsString();
      List<Map<String, dynamic>> clientes = produtoJson.deserializaJson(contJson);
      listaProdutos = ObservableList<Map<String, dynamic>>.of(clientes);
      log('Obteve os clientes $listaProdutos');
    }catch (e){
      log('Erro ao obter os clientes');
      rethrow;
    }
  }

  @action
  void setFiltroProd(String filter){
    filtroProd = filter;
  }

  @action
  void setCliente(Map<String, dynamic> prod){
    prodSele = prod;
  }

  @computed
List<Map<String, dynamic>> get listaFiltrada {
  if (filtroProd.isEmpty) {
    // Se não há filtro, retorna todos os clientes.
    // Retornar listaClientes.toList() cria uma nova lista, o que é seguro.
    return listaProdutos.toList();
  } else {

    return listaProdutos.where((cliente) {
      // Obtém e normaliza o nome do cliente (para PF e PJ)
      final String nomeCliente = cliente['nome']?.toString().toLowerCase() ?? '';    

      return nomeCliente.contains(filtroProd.toLowerCase());
    }).toList();
  }
}

  @observable
bool exibeListaProd = false;

@action
void setListaProd(bool value) {
  exibeListaProd = value;
}

@action
void selecionarProd(Map<String, dynamic> produtoSelecionado) {
  
  final clienteForm = Get.find<ProdutoFormStore>();

  prodSele = produtoSelecionado;
  log('Cliente Selecionado $prodSele e $produtoSelecionado');

  clienteForm.resetForm();

  produtoSelecionado.forEach((key, value) {
    clienteForm.controllerCod.text = produtoSelecionado['cod']?.toString() ?? '';    
    clienteForm.controllerNomeProd.text = produtoSelecionado['nome']?.toString() ?? '';
    clienteForm.controllerNcm.text = produtoSelecionado['ncm']?.toString() ?? '';
    clienteForm.controllerUnidade.text = produtoSelecionado['un']?.toString() ?? '';
    clienteForm.controllerMarca.text = produtoSelecionado['marca']?.toString() ?? '';
    clienteForm.controllerCst.text = produtoSelecionado['cst']?.toString() ?? '';
    clienteForm.controllerCusto.text = produtoSelecionado['custo']?.toString() ?? '';
    clienteForm.controllerVenda.text = produtoSelecionado['venda']?.toString() ?? '';
  
  });
}

  Future<File> obtemFileProd() async{
    try {
      Directory dir = await getApplicationDocumentsDirectory();              
        String path =  dir.path;        
        File f = File('$path/produtos.json');        
        bool fExiste = await f.exists();        
        if (fExiste){
          return f;
        }else {
          List<Map<String, dynamic>> mapProds = [];
          final jClientes = jsonEncode(mapProds);
          await f.writeAsString(jClientes);
          return f;
        }
    } catch (e) {
      log('erro ao obter Arquivo de clientes $e');
      rethrow;
    }      
  }

  Future<int> obtemCod() async{
    Produto produtoJson = Produto();
    try {      
      File json = await obtemFileProd();
      String contJson = await json.readAsString();
      if (contJson != '[]' ){
        List<Map<String, dynamic>> listaDeProds = produtoJson.deserializaJson(contJson);        
        Map<String, dynamic> ultimoProd = listaDeProds.last;        
        int ultimoCod = ultimoProd['cod'];
        ultimoCod++;
        return ultimoCod;
      }else {
        return 1;
      }
    }catch (e) {
      log('Erro ao obter o id $e');
      rethrow;
    }
        
  }

  salvaCliente() async{
     Produto produtoJson = Produto();
    final clienteForm = Get.find<ProdutoFormStore>();
    try{
      int cod = await obtemCod();
      final fProd = await obtemFileProd();
      String contJson = await fProd.readAsString();           
      List<Map<String, dynamic>> produtos = produtoJson.deserializaJson(contJson);
      final produto = <String, dynamic>{};
      clienteForm.prodValues.forEach((key, value) {
        produto[key] = value;
      });
      produto["cod"]=cod;
      produtos.add(produto);
      final jProdutos = jsonEncode(produtos);
      await fProd.writeAsString(jProdutos);  
      log('Salvou porraa $produtos');
    }catch (e){
      log('Erro ao salvar o cliente $e');
      rethrow;
    }
  }


}

