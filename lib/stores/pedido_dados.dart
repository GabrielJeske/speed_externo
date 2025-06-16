
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/commom/objetos/produto.dart';

part 'pedido_dados.g.dart';


class DadosPedidoStore =_DadosPedidoStoreBase with _$DadosPedidoStore;

abstract class _DadosPedidoStoreBase with Store{

  @observable
  int _itemCounter = 0;

  @observable
  Pedido pedido = Pedido(listProd: []);

  @observable
  bool edit = false;

  @observable
  ObservableList<Produto> listaProdutos = ObservableList<Produto> ();

  Map<String, TextEditingController> controllersQtd = {};

  @observable
  
  ObservableMap<String, TextEditingController> controllersTotal = ObservableMap();
 

void setQtd(String value, Produto produto) {
  // 1. Encontra o índice do produto na lista para garantir a modificação correta.
  final index = listaProdutos.indexWhere((p) => p.nProd == produto.nProd);
  if (index == -1) {
    // Se não encontrar o produto, não faz nada.
    return;
  }

  // --- Lógica de cálculo e atualização ---

  // 2. Converte a quantidade (value) de forma segura.
  // int.tryParse retorna null se a string for inválida (ex: ''), em vez de quebrar.
  final int quantidade = int.tryParse(value) ?? 0;

  // Atualiza a quantidade no objeto do produto.
  listaProdutos[index].quantidade = value;

  // 3. Converte o valor de venda de forma segura.
  double valorVenda = 0.0;
  final vendaString = listaProdutos[index].venda;

  if (vendaString != null && vendaString.isNotEmpty) {
    String valorLimpo = vendaString
        .replaceAll('R\$', '')
        .trim()
        .replaceAll('.', '')
        .replaceAll(',', '.');
    valorVenda = double.tryParse(valorLimpo) ?? 0.0;
  }

  // 4. Calcula o novo total.
  final double novoTotal = valorVenda * quantidade;

  // 5. ATUALIZA O TOTAL no objeto do produto.
  // Esta é a parte crucial que faltava.
  listaProdutos[index].total = novoTotal.toStringAsFixed(2);
}

  @action
  void setEdit (bool value){
    edit=value;
  }
  
  
@action
void addProd(Produto prod) {
  _itemCounter++;

  // (Lógica de cálculo do totalCalculado que já fizemos)
  double vendaValor = 0.0;
  if (prod.venda != null && prod.venda!.isNotEmpty) {
    String valorLimpo = prod.venda!
        .replaceAll('R\$', '').trim().replaceAll('.', '').replaceAll(',', '.');
    vendaValor = double.tryParse(valorLimpo) ?? 0.0;
  }
  const double quantidadeValor = 1.0;
  double totalCalculado = vendaValor * quantidadeValor;
  // --- Fim da lógica ---

  Produto newProd = prod.copyWith(
    nProd: '$_itemCounter',
    quantidade: '1',
    total: totalCalculado.toStringAsFixed(2),
  );
  
  // Adiciona o controller de quantidade
  controllersQtd['$_itemCounter'] = TextEditingController(text: '1');

  // Adiciona o NOVO controller de total ao mapa observável
  controllersTotal['$_itemCounter'] = TextEditingController(text: newProd.total);

  listaProdutos.add(newProd);
}

 @action
  void addClie(Cliente clie){    
    pedido.codClie = pedido.cod;
  }
  
}