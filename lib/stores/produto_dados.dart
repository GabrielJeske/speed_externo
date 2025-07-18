import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/produto_controller.dart';

part 'produto_dados.g.dart';


class DadosProdutoStore =_DadosProdutoStoreBase with _$DadosProdutoStore;

abstract class _DadosProdutoStoreBase with Store{

  

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  @observable
  String filtroProd = '';

  @action
  void setFiltroProd(String filter){
    filtroProd = filter;
  }

  @observable
  Produto prodSele = Produto(); 

  final Box<Produto> produtosBox = Hive.box<Produto>('Produtos');

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
  Future<void> obtemProdutos() async {
    try {
      await atualizaProdutos();
      final produtos = produtosBox.values.toList();
      listaProdutos = ObservableList<Produto>.of(produtos);      
    } catch (e) {
      rethrow;
    }
  }


  String geraMd5(String texto) {
    var bytes = utf8.encode(texto);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
  
  Future<void> atualizaProdutos() async {
      var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/cliente');
    try {

      //List<Produto> produtosLocais = produtosBox.values.toList();
      //String corpoJson = jsonEncode(produtosLocais.map((produto) => produto.toJson()).toList()); 
      //String md5 = geraMd5(corpoJson);

      //var resposta = await http.post(url, headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: md5);
      var resposta = await http.get(url);

      if (resposta.statusCode == 200){ 
        List<dynamic> listaRecebida = jsonDecode(resposta.body);

        List<Produto> produtosAtualizaodos =  listaRecebida.map((json) => Produto.fromJson(json as Map<String, dynamic>)).toList();

        await produtosBox.clear();      
        await produtosBox.putAll(Map.fromEntries(produtosAtualizaodos.map((produto) => MapEntry(produto.cod, produto))));  

      }else if (resposta.statusCode == 404) {
      }else {
      }
    } catch (e) {
      rethrow;
    }
  }

}

