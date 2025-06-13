// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosPedidoStore on _DadosPedidoStoreBase, Store {
  late final _$_itemCounterAtom =
      Atom(name: '_DadosPedidoStoreBase._itemCounter', context: context);

  @override
  int get _itemCounter {
    _$_itemCounterAtom.reportRead();
    return super._itemCounter;
  }

  @override
  set _itemCounter(int value) {
    _$_itemCounterAtom.reportWrite(value, super._itemCounter, () {
      super._itemCounter = value;
    });
  }

  late final _$pedidoAtom =
      Atom(name: '_DadosPedidoStoreBase.pedido', context: context);

  @override
  Pedido get pedido {
    _$pedidoAtom.reportRead();
    return super.pedido;
  }

  @override
  set pedido(Pedido value) {
    _$pedidoAtom.reportWrite(value, super.pedido, () {
      super.pedido = value;
    });
  }

  late final _$editAtom =
      Atom(name: '_DadosPedidoStoreBase.edit', context: context);

  @override
  bool get edit {
    _$editAtom.reportRead();
    return super.edit;
  }

  @override
  set edit(bool value) {
    _$editAtom.reportWrite(value, super.edit, () {
      super.edit = value;
    });
  }

  late final _$listaProdutosAtom =
      Atom(name: '_DadosPedidoStoreBase.listaProdutos', context: context);

  @override
  ObservableList<Produto> get listaProdutos {
    _$listaProdutosAtom.reportRead();
    return super.listaProdutos;
  }

  @override
  set listaProdutos(ObservableList<Produto> value) {
    _$listaProdutosAtom.reportWrite(value, super.listaProdutos, () {
      super.listaProdutos = value;
    });
  }

  late final _$_DadosPedidoStoreBaseActionController =
      ActionController(name: '_DadosPedidoStoreBase', context: context);

  @override
  void setQtd(String value, Produto produto) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.setQtd');
    try {
      return super.setQtd(value, produto);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setEdit(bool value) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.setEdit');
    try {
      return super.setEdit(value);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addProd(Produto prod) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.addProd');
    try {
      return super.addProd(prod);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void addClie(Cliente clie) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.addClie');
    try {
      return super.addClie(clie);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedido: ${pedido},
edit: ${edit},
listaProdutos: ${listaProdutos}
    ''';
  }
}
