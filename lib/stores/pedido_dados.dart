import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
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

  final Map<String, TextEditingController> _quantidadeControllers = {};

  // 2. ADIÇÃO: Um método para a UI pegar o controller correto.
  TextEditingController getControllerParaProduto(Produto produto) {
  final controller = _quantidadeControllers[produto.nProd];
  if (controller == null) {
    // Isso indica um erro de lógica em algum lugar, mas evita o crash.
    // Lança uma exceção clara que te ajuda a depurar.
    throw Exception('Controller não encontrado para o produto com nProd: ${produto.nProd}');
  }
  return controller;
}
@action
void setQtd(String value, Produto produto) {
  final index = listaProdutos.indexWhere((prod) => prod.nProd == produto.nProd);

  if (index != -1) {
    final produtoAtualizado = produto.copyWith(quantidade: value);
    listaProdutos[index] = produtoAtualizado;
  }
}

  @action
  void setEdit (bool value){
    edit=value;
  }
  
  @action
  void addProd(Produto prod){
    _itemCounter++;
    Produto newProd = prod.copyWith(
      nProd: '$_itemCounter',
      quantidade: '1',
    );

      final controller = TextEditingController(text: newProd.quantidade);
    _quantidadeControllers[newProd.nProd!] = controller;

    listaProdutos.add(newProd);  

  }

   @action
  void removerProd(Produto produto) {
    // Pega o controller do nosso depósito
    final controller = _quantidadeControllers[produto.nProd];

    // Desliga o controller para evitar vazamento de memória
    controller?.dispose();

    // Remove o controller do depósito
    _quantidadeControllers.remove(produto.nProd);

    // Finalmente, remove o produto da lista da UI
    listaProdutos.remove(produto);
  }

  @action
  void addClie(Cliente clie){    
    pedido.codClie = pedido.cod;
  }


  

  

}

