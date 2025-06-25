import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:path_provider/path_provider.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';
import 'package:speed_externo/stores/pedido_controller.dart';

part 'pedido_dados.g.dart';


class DadosPedidoStore =_DadosPedidoStoreBase with _$DadosPedidoStore;

abstract class _DadosPedidoStoreBase with Store{

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
    log( 'Calculando desconto porcentagem com valor: $value');
    String descRealLimpo = value.replaceAll(',', '.').trim();
    log('Desc Real Limpo: $descRealLimpo');
    descReal = double.tryParse(descRealLimpo) ?? 0.0;
    log('Desc Porcent Inicial: $descPorcent');
    descPorcent = (descReal / totalProd) * 100;
    desconto = descReal;
    log('Desc Porcent: $descPorcent');
    controllerDescPorcent.text = descPorcent.toStringAsFixed(2).replaceAll('.', ',');  
    calculaTotalPedido();
  }

  void calculaDescReal( String value) {
    log('Calculando desconto real com valor: $value');
    String descPorcentLimpo = value.replaceAll(',', '.').trim();
    log('Desc Porcent Limpo: $descPorcentLimpo');
    descReal = double.tryParse(descPorcentLimpo) ?? 0.0;
    log('Desc Real Inicial: $descReal');
    descReal = (totalProd * descReal) / 100;
    desconto = descReal;
    log('Desc Real: $descReal = ($totalProd * $descReal) / 100');
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
    log('Valor Total dos Produtos: $valorProdutos');
    log('Total do Pedido: $totalPedido');
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

 


  Future<File> obtemFilePedido() async{
    try {
      Directory dir = await getApplicationDocumentsDirectory();              
        String path =  dir.path;        
        File f = File('$path/pedidos01.json');        
        bool fExiste = await f.exists();        
        if (fExiste){
          return f;
        }else {
          List<Pedido> mapPedidos = [];
          final jClientes = jsonEncode(mapPedidos);
          await f.writeAsString(jClientes);
          return f;
        }
    } catch (e) {
      log('erro ao obter Arquivo de pedidos $e');
      rethrow;
    }      
  }

  Future<int> obtemCodPedido() async{
    Pedido pedidoJson = Pedido(listProd: []);
    try {      
      File json = await obtemFilePedido();
      String contJson = await json.readAsString();
      if (contJson != '[]' ){
        List<Pedido> listaDePedidos = pedidoJson.obtemPedidos(contJson);
        int id = 0;        
        for (Pedido pedido in listaDePedidos){          
          int a = int.parse(pedido.cod ?? '0' );
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

  salvaPedido() async{
    Pedido pedido = Pedido(listProd: []);
    final fatur = Get.find<FaturamentoController>();
    final pedidoController = Get.find<PedidoStore>();
    try{      
      String date = "${DateTime.now().day.toString().padLeft(2, '0')}/"
                    "${DateTime.now().month.toString().padLeft(2, '0')}/"
                    "${DateTime.now().year}";                
      int id = await obtemCodPedido();
      
      final fPedidos = await obtemFilePedido();
      
      String contJson = await fPedidos.readAsString();
   
      List<Pedido> pedidos = pedido.obtemPedidos(contJson);
    
      pedido = pedido.copyWith(
        faturamento: fatur.faturamento,
        listProd: listaProdutos,
        cod: id.toString(),
        data: date,
        tipo: pedidoController.pedido.tipo,
        codClie: pedidoController.pedido.codClie,
        status: 'pendente',
      );
      
      pedidos.add(pedido);
      final jPedido = jsonEncode(pedidos);
      await fPedidos.writeAsString(jPedido);  
      log('Salvou porraa $jPedido');
    }catch (e){
      throw 'Erro ao salvar o pedido $e';
    }
  }

  //  @action
  // void addClie(Cliente clie){    
  //   pedido.codClie = clie.id;
  // }
  
  
}
