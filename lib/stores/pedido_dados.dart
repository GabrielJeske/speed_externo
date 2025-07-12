import 'dart:convert';
import 'dart:developer';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';

part 'pedido_dados.g.dart';


class DadosPedidoStore =_DadosPedidoStoreBase with _$DadosPedidoStore;

abstract class _DadosPedidoStoreBase with Store{

  @observable
  ObservableList<Pedido> listaDePedidos = ObservableList<Pedido> ();

  Pedido pedido = Pedido(listProd: []);

  @observable
  double descPorcent = 0.0;
  
  @observable
  double descReal = 0.0;

  @observable
  double desconto = 0.0;

  @observable
  double totalPedido = 0.0;

  @observable
  double totalProd = 0.0;

  @observable
  int _itemCounter = 0;

  final Box<Pedido> pedidosBox = Hive.box<Pedido>('Pedidos');


  @observable
  bool edit = false;

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  Map<String, TextEditingController> controllersQtd = {};
  Map<String, TextEditingController> controllersTotal = {};

  TextEditingController controllerTotalPedido = TextEditingController();
  TextEditingController controllerTotalProd = TextEditingController();
  TextEditingController controllerDescPorcent = TextEditingController();
  TextEditingController controllerDescReal = TextEditingController();

  TextEditingController getControllerQtd(Produto produto) {
    final controller = controllersQtd[produto.nProd];
    if (controller == null) {
      throw Exception('Controller não encontrado para o produto com nProd: ${produto.nProd}');
    }
    return controller;
  }

  
  TextEditingController getControllerTotal(Produto produto) {
    final controller = controllersTotal[produto.nProd];
    if (controller == null) {
      throw Exception('Controller não encontrado para o produto com nProd: ${produto.nProd}');
    }
    return controller;
  }  


  @action
  void setEdit (bool value){
    edit=value;
  }
  
  
@action
void addProd(Produto prod) {
  _itemCounter++;

  Produto newProd = prod.copyWith(
    nProd: '$_itemCounter',
    quantidade: '1',
    total: prod.venda,
  );
  
  final controllerQtd = TextEditingController(text: newProd.quantidade);
  controllersQtd[newProd.nProd!] = controllerQtd;

  final controllerTotal = TextEditingController(text: newProd.venda);
  controllersTotal[newProd.nProd!] = controllerTotal;


  controllerQtd.addListener(() => calculaTotal(newProd));

  listaProdutos.add(newProd);

  calculaTotal(newProd);
  calculaTotalPedido();

  if (controllerDescPorcent.text.isNotEmpty) {
    calculaDescReal(controllerDescPorcent.text);
  }

}

  void calculaDescPorcent(String value) {
    String descRealLimpo = value.replaceAll(',', '.').trim();
    descReal = double.tryParse(descRealLimpo) ?? 0.0;
    descPorcent = (descReal / totalProd) * 100;
    desconto = descReal;
    controllerDescPorcent.text = descPorcent.toStringAsFixed(2).replaceAll('.', ',');  
    calculaTotalPedido();
  }

  void calculaDescReal( String value) {
    String descPorcentLimpo = value.replaceAll(',', '.').trim();
    descReal = double.tryParse(descPorcentLimpo) ?? 0.0;
    descReal = (totalProd * descReal) / 100;
    desconto = descReal;
    controllerDescReal.text = descReal.toStringAsFixed(2).replaceAll('.', ',');
    calculaTotalPedido();
  }

  void calculaTotalPedido (){
    double valorTotalPedido = 0;
    double valorProdutos = 0;
    if (controllersTotal.isEmpty) {
      controllerTotalPedido.text = '0,00';
      totalPedido = 0.0;
      controllerTotalProd.text = '0,00';
      totalProd = 0.0;
      return;
    } else {
     controllersTotal.forEach((key, controller) {
      String valorVendaLimpo = controller.text
        ?.replaceAll(',', '.')
        .trim() ?? '0.0';
        double valorTotal = double.tryParse(valorVendaLimpo) ?? 0.0;

          valorProdutos  = (valorProdutos + valorTotal);
      });
       valorTotalPedido = (valorProdutos - desconto);              
    }
  
    controllerTotalPedido.text = ' ${valorTotalPedido.toStringAsFixed(2).replaceAll('.', ',')}';
    controllerTotalProd.text = ' ${valorProdutos.toStringAsFixed(2).replaceAll('.', ',')}';
    totalPedido = valorTotalPedido;
    totalProd = valorProdutos;
  }

  void calculaTotal (Produto produto){

    final controllerQtd = controllersQtd[produto.nProd];
    final controllerTotal = controllersTotal[produto.nProd];

    if (controllerQtd == null || controllerTotal == null) return;

    int quantidade = int.tryParse(controllerQtd.text) ?? 0;

    String valorVendaLimpo = produto.venda
        ?.replaceAll(',', '.')
        .trim() ?? '0.0';
    final double valorVenda = double.tryParse(valorVendaLimpo) ?? 0.0;

    final double total = quantidade * valorVenda;

  
    controllerTotal.text = ' ${total.toStringAsFixed(2).replaceAll('.', ',')}';
    
  }

  @action
  void removerProd(Produto produto) {
    
    final controllerQtd = controllersQtd[produto.nProd];
    final controllerTotal = controllersTotal[produto.nProd];

    controllerQtd?.removeListener(() => calculaTotal(produto));

    controllerQtd?.dispose();
    controllerTotal?.dispose();

    controllersQtd.remove(produto.nProd);
    controllersTotal.remove(produto.nProd); 

    listaProdutos.remove(produto);
    calculaTotalPedido();
  }

   @action
    Future obtemPedidos () async{
      try{
        await atualizaPedidos();
        final pedidos = pedidosBox.values.toList();
        listaDePedidos = ObservableList<Pedido>.of(pedidos);
      }catch (e){
        rethrow;
      }
  }  

  salvaPedido() async{
    Pedido pedido = Pedido(listProd: []);
    final fatur = Get.find<FaturamentoController>();
    final pedidoController = Get.find<PedidoStore>();
    var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/clientes');
    try{      
      String date = "${DateTime.now().day.toString().padLeft(2, '0')}/"
                    "${DateTime.now().month.toString().padLeft(2, '0')}/"
                    "${DateTime.now().year}";                
    
      pedido = pedido.copyWith(
        faturamento: fatur.faturamento,
        listProd: listaProdutos,
        data: date,
        tipo: pedidoController.pedido.tipo,
        codClie: pedidoController.pedido.codClie,
        status: 'pendente',
      );

      String ped = jsonEncode(pedido.toJson());

      //var resposta = await http.post(url, body: ped);
      var resposta = await http.post(url);

      if (resposta.statusCode == 404){
      }else {
      }

    }catch (e){
      throw 'Erro ao salvar o pedido $e';
    }
  }

  String geraMd5(String texto) {
    var bytes = utf8.encode(texto);
    var digest = md5.convert(bytes);
    return digest.toString();
  }
  
  Future<void> atualizaPedidos() async {
      var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/pedidos');
    try {
//      listaClientes = ObservableList<Cliente> ();
      List<Pedido> clientesLocais = pedidosBox.values.toList();
      String corpoJson = jsonEncode(clientesLocais.map((cliente) => cliente.toJson()).toList()); 
      String md5 = geraMd5(corpoJson);

      //var resposta = await http.post(url, headers: {'Content-Type': 'application/json; charset=UTF-8'}, body: md5);
      var resposta = await http.get(url);

      if (resposta.statusCode == 200){
        List<dynamic> listaRecebida = jsonDecode(resposta.body);

        List<Pedido> pedidosAtualizados = listaRecebida.map((json) => Pedido.fromJson(json as Map<String, dynamic>)).toList();

        await pedidosBox.clear();      
        await pedidosBox.putAll(Map.fromEntries(pedidosAtualizados.map((pedido) => MapEntry(pedido.cod, pedido))));  

      }else if (resposta.statusCode == 404) {
      }else {
      }
    } catch (e) {
      rethrow;
    }
  }
  
}
