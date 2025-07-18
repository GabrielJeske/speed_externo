import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/funcoes/date.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';

part 'pedido_dados.g.dart';


class DadosPedidoStore =_DadosPedidoStoreBase with _$DadosPedidoStore;

abstract class _DadosPedidoStoreBase with Store{

  final Box<Pedido> pedidosBox = Hive.box<Pedido>('Pedidos');

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
  int itemCount = 0;

  
  @observable
  bool edit = false;

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  @observable
  Produto? prodRemovido;
  int? codProdRemovido;


  Map<String, TextEditingController> controllersQtd = {};
  Map<String, TextEditingController> controllersTotal = {};
  TextEditingController controllerTotalPedido = TextEditingController();
  TextEditingController controllerTotalProd = TextEditingController();
  TextEditingController controllerDescPorcent = TextEditingController();
  TextEditingController controllerDescReal = TextEditingController();

  TextEditingController getControllerQtd(Produto produto) {
    final controller = controllersQtd['${produto.nProd}'];
    if (controller == null) {
      throw Exception('Controller não encontrado para o produto com nProd: ${produto.nProd}');
    }
    return controller;
  }

  
  TextEditingController getControllerTotal(Produto produto) {
    final controller = controllersTotal['${produto.nProd}'];
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
    itemCount++;

    Produto novoProd = prod.copyWith(
      nProd: itemCount,
      quantidade: 1,
      total: prod.venda,
    );
    
    final controllerQtd = TextEditingController(text: '${novoProd.nProd}');
    controllersQtd['${novoProd.nProd}'] = controllerQtd;

    final controllerTotal = TextEditingController(text: '${novoProd.nProd}');
    controllersTotal['${novoProd.nProd}'] = controllerTotal;


    controllerQtd.addListener(() => calculaTotal(novoProd));

    listaProdutos.add(novoProd);

    calculaTotal(novoProd);
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
      String valorVendaLimpo = controller.text.replaceAll(',', '.').trim();
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

    final controllerQtd = controllersQtd['${produto.nProd}'];
    final controllerTotal = controllersTotal['${produto.nProd}'];

    if (controllerQtd == null || controllerTotal == null) return;

    int quantidade = int.tryParse(controllerQtd.text) ?? 0;

    double valorVendaLimpo = produto.venda!;

    final double total = quantidade * valorVendaLimpo;

  
    controllerTotal.text = ' ${total.toStringAsFixed(2).replaceAll('.', ',')}';
    
  }

  @action
  void removerProd(Produto produto) {

    prodRemovido = produto.copyWith();
    codProdRemovido = listaProdutos.indexOf(produto);
    
    final controllerQtd = controllersQtd['${produto.nProd}'];
    final controllerTotal = controllersTotal['${produto.nProd}'];

    controllerQtd?.removeListener(() => calculaTotal(produto));

    controllerQtd?.dispose();
    controllerTotal?.dispose();

    controllersQtd.remove('${produto.nProd}');
    controllersTotal.remove('${produto.nProd}'); 

    listaProdutos.remove(produto);
    calculaTotalPedido();

     Get.snackbar(
      'Produto Removido',
      '"${prodRemovido!.nome}" foi removido.',      
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 15), // Snackbar visível por 15 segundos
      mainButton: TextButton(
        onPressed: () {
          desfazerRemocao();
          Get.back();
        },
        child: Text(
          'Desfazer',
          style: TextStyle(color: Theme.of(Get.context!).colorScheme.onPrimary),
        ),
      ),
      backgroundColor: Theme.of(Get.context!).colorScheme.primary,
      colorText: Theme.of(Get.context!).colorScheme.onPrimary,
      snackStyle: SnackStyle.FLOATING,
    );
  }
  
  @action
  void desfazerRemocao() {
    if (prodRemovido != null && codProdRemovido != null) {
      if (codProdRemovido! <= listaProdutos.length) {
        listaProdutos.insert(codProdRemovido!, prodRemovido!);
      } else {
        listaProdutos.add(prodRemovido!);
      }
      final controllerQtd = TextEditingController(text: '${prodRemovido!.quantidade}');
      controllersQtd['${prodRemovido!.nProd}'] = controllerQtd;

      final controllerTotal = TextEditingController(text: '${prodRemovido!.total}');
      controllersTotal['${prodRemovido!.nProd}'] = controllerTotal;

      controllerQtd.addListener(() => calculaTotal(prodRemovido!));


      calculaTotalPedido();

      prodRemovido = null;
      codProdRemovido = null;

      Get.snackbar(
        'Desfeito',
        'A remoção foi desfeita.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Theme.of(Get.context!).colorScheme.secondary,
        colorText: Theme.of(Get.context!).colorScheme.onSecondary,
      );
    }
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

    @action
  void resetPedido() {
    final pedidoController = Get.find<PedidoStore>();
    final faturamento = Get.find<FaturamentoController>();

    pedidoController.resetForm();
    faturamento.resetFaturamento();

    listaProdutos.clear(); // Limpa a lista de produtos do pedido atual
    controllersQtd.forEach((key, controller) => controller.dispose()); // Descarta controllers de quantidade
    controllersQtd.clear(); // Limpa o mapa de controllers de quantidade
    controllersTotal.forEach((key, controller) => controller.dispose()); // Descarta controllers de total
    controllersTotal.clear(); // Limpa o mapa de controllers de total

    // Zera os totais e descontos
    descPorcent = 0.0;
    descReal = 0.0;
    desconto = 0.0;
    totalPedido = 0.0;
    totalProd = 0.0;
    itemCount = 0; // Reseta o contador de itens para novos nProd únicos

    // Limpa os TextEditingControllers da UI do pedido
    controllerTotalPedido.text = '0,00';
    controllerTotalProd.text = '0,00';
    controllerDescPorcent.text = ''; // Ou '0,00'
    controllerDescReal.text = ''; // Ou '0,00'

    // Zera as variáveis de "desfazer"
    prodRemovido = null;
    codProdRemovido = null;

    // Se houver outras variáveis de estado no DadosPedidoStore que precisam ser resetadas, adicione-as aqui.
    // Exemplo: se 'edit' deve ser false por padrão para um novo pedido
     edit = false; 
  }

  salvaPedido() async{
    Pedido pedido = Pedido(listProd: []);
    final fatur = Get.find<FaturamentoController>();
    final pedidoController = Get.find<PedidoStore>();
    var url = Uri.parse('https://1587bcd2-f1c9-4bd7-b4fa-10940fdf1042.mock.pstmn.io/clientes');
    try{      
      String data = Data.getData;
    
      pedido = pedido.copyWith(
        faturamento: fatur.faturamento,
        listProd: listaProdutos,
        data: data,
        tipo: pedidoController.pedido.tipo,
        codClie: pedidoController.pedido.codClie,
        status: 'pendente',
      );

      // Map<String, dynamic> teste = pedido.toJson();

      // String ped = jsonEncode(pedido.toJson());

      //var resposta = await http.post(url, body: ped);
      var resposta = await http.post(url);

      if (resposta.statusCode == 404){
        resetPedido();
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
      // List<Pedido> clientesLocais = pedidosBox.values.toList();
      // String corpoJson = jsonEncode(clientesLocais.map((cliente) => cliente.toJson()).toList()); 
      // String md5 = geraMd5(corpoJson);

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
