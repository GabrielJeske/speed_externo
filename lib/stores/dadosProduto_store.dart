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
      List<Map<String, dynamic>> produtos = produtoJson.deserializaJson(contJson);
      listaProdutos = ObservableList<Map<String, dynamic>>.of(produtos);
      log('Obteve os Produtos $listaProdutos');
    }catch (e){
      log('Erro ao obter os Produtos');
      rethrow;
    }
  }

  @action
  void setFiltroProd(String filter){
    filtroProd = filter;
  }

  @action
  void setProduto(Map<String, dynamic> prod){
    prodSele = prod;
  }

  @computed
List<Map<String, dynamic>> get listaFiltrada {
  if (filtroProd.isEmpty) {
    return listaProdutos.toList();
  } else {

    return listaProdutos.where((produto) {      
      final String nomeProduto = produto['nome']?.toString().toLowerCase() ?? '';    

      return nomeProduto.contains(filtroProd.toLowerCase());
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
  
  final produtoForm = Get.find<ProdutoFormStore>();

  prodSele = produtoSelecionado;
  log('Produto Selecionado $prodSele e $produtoSelecionado');

  produtoForm.resetForm();

  produtoSelecionado.forEach((key, value) {
    produtoForm.controllerCod.text = produtoSelecionado['cod'].toString();    
    produtoForm.controllerNomeProd.text = produtoSelecionado['nome'];
    produtoForm.controllerNcm.text = produtoSelecionado['ncm'];
    produtoForm.controllerUnidade.text = produtoSelecionado['un'];
    produtoForm.controllerMarca.text = produtoSelecionado['marca'];
    produtoForm.controllerCst.text = produtoSelecionado['cst'];
    produtoForm.controllerCusto.text = produtoSelecionado['custo'];
    produtoForm.controllerVenda.text = produtoSelecionado['venda'];
  
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
          final jProdutos = jsonEncode(mapProds);
          await f.writeAsString(jProdutos);
          return f;
        }
    } catch (e) {
      log('erro ao obter Arquivo de produtos $e');
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

  salvaProduto() async{
     Produto produtoJson = Produto();
    final produtoForm = Get.find<ProdutoFormStore>();
    try{
      int cod = await obtemCod();
      final fProd = await obtemFileProd();
      String contJson = await fProd.readAsString();           
      List<Map<String, dynamic>> produtos = produtoJson.deserializaJson(contJson);
      final produto = <String, dynamic>{};
      produtoForm.prodValues.forEach((key, value) {
        produto[key] = value;
      });
      produto["cod"]=cod;
      produtos.add(produto);
      final jProdutos = jsonEncode(produtos);
      await fProd.writeAsString(jProdutos);  
      log('Salvou porraa $produtos');
    }catch (e){
      log('Erro ao salvar o produto $e');
      rethrow;
    }
  }


}

