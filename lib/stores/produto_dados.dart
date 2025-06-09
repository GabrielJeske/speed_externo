import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/produto_controller.dart';

part 'produto_dados.g.dart';


class DadosProdutoStore =_DadosProdutoStoreBase with _$DadosProdutoStore;

abstract class _DadosProdutoStoreBase with Store{

  

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  @observable
  String filtroProd = '';

  @observable
  Produto prodSele = Produto(); 

  
  @action
  void setFiltroProd(String filter){
    filtroProd = filter;
  }


  @action
  void setProduto(Produto prod){
    prodSele = prod;
  }

  @computed
List<Produto> get listaFiltrada {
  if (filtroProd.isEmpty) {
    return listaProdutos.toList();
  } else {

    return listaProdutos.where((produto) {      
      final String nomeProduto = produto.nome?.toString().toLowerCase() ?? '';    

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
void selecionarProd(Produto produtoSelecionado) {
  
  final produtoForm = Get.find<ProdutoFormStore>();

  prodSele = produtoSelecionado;
  log('Produto Selecionado $prodSele e $produtoSelecionado');

  produtoForm.resetForm();

  produtoForm.controllerCod.text = prodSele.cod.toString();
  produtoForm.controllerNomeProd.text = prodSele.nome.toString();
  produtoForm.controllerNcm.text = prodSele.ncm.toString();
  produtoForm.controllerUnidade.text = prodSele.unidade.toString();
  produtoForm.controllerMarca.text = prodSele.marca.toString();
  produtoForm.controllerApre.text = prodSele.apresentacao.toString();
  produtoForm.controllerGrupo1.text = prodSele.grupo1.toString();
  produtoForm.controllerGrupo2.text = prodSele.grupo2.toString();
  produtoForm.controllerGrupo3.text = prodSele.grupo3.toString();
  produtoForm.controllerCst.text = prodSele.cst.toString();
  produtoForm.controllerCusto.text = prodSele.custo.toString();
  produtoForm.controllerFabrica.text = prodSele.fabrica.toString();
  produtoForm.controllerVenda.text = prodSele.venda.toString();
  produtoForm.controllerEstAtual.text = prodSele.estoqueatual.toString();
  produtoForm.controllerEstParcial.text = prodSele.estoqueparcial.toString();
  produtoForm.controllerQuant.text = prodSele.quantidade.toString();
  produtoForm.controllerUnit.text = prodSele.unitario.toString();
  produtoForm.controllerTotal.text = prodSele.total.toString();    
}


@action
  Future obtemProdutos () async{
    Produto produtoJson = Produto();
    try{
      final fProduto = await obtemFileProd();
      log('Obteve o arquivo de produtos $fProduto');
      String contJson = await fProduto.readAsString();
      log('Obteve o conteudo do arquivo de produtos $contJson');    
      List<Produto> produtos = produtoJson.obtemProdutos(contJson);
      log('Criou a lista de produtos $produtos');
      listaProdutos = ObservableList<Produto>.of(produtos);
      log('Obteve os Produtos $listaProdutos');
    }catch (e){
      log('Erro ao obter os Produtos');
      rethrow;
    }
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
          List<Produto> mapProds = [];
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
        List<Produto> listaDeProds = produtoJson.obtemProdutos(contJson);        
        int codigo = 0;
        for (Produto produto in listaDeProds){  
          int a = int.parse(produto.cod ?? '0');                 
          if ( a > codigo){
              codigo = a;
          }
        }
        codigo++;
        return codigo;
      }else {
        return 1;
      }
    }catch (e) {
      log('Erro ao obter o id $e');
      rethrow;
    }
        
  }

  salvaProduto() async{    
    final produtoForm = Get.find<ProdutoFormStore>();
    try{
      int cod = await obtemCod();
      final fProd = await obtemFileProd();
      String contJson = await fProd.readAsString();           
      List<Produto> produtos = produtoForm.prod.obtemProdutos(contJson);    
      produtoForm.prod.cod='$cod';
      produtos.add(produtoForm.prod);
      final jProdutos = jsonEncode(produtos);
      await fProd.writeAsString(jProdutos);  
      log('Salvou porraa $produtos');
    }catch (e){
      log('Erro ao salvar o produto $e');
      rethrow;
    }
  }


}

