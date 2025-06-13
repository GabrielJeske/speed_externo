
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


    listaProdutos.add(newProd);  
  }

  @action
  void addClie(Cliente clie){    
    pedido.codClie = pedido.cod;
  }
}