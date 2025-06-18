// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosPedidoStore on _DadosPedidoStoreBase, Store {
  late final _$descPorcentAtom =
      Atom(name: '_DadosPedidoStoreBase.descPorcent', context: context);

  @override
  double get descPorcent {
    _$descPorcentAtom.reportRead();
    return super.descPorcent;
  }

  @override
  set descPorcent(double value) {
    _$descPorcentAtom.reportWrite(value, super.descPorcent, () {
      super.descPorcent = value;
    });
  }

  late final _$descRealAtom =
      Atom(name: '_DadosPedidoStoreBase.descReal', context: context);

  @override
  double get descReal {
    _$descRealAtom.reportRead();
    return super.descReal;
  }

  @override
  set descReal(double value) {
    _$descRealAtom.reportWrite(value, super.descReal, () {
      super.descReal = value;
    });
  }

  late final _$descontoAtom =
      Atom(name: '_DadosPedidoStoreBase.desconto', context: context);

  @override
  double get desconto {
    _$descontoAtom.reportRead();
    return super.desconto;
  }

  @override
  set desconto(double value) {
    _$descontoAtom.reportWrite(value, super.desconto, () {
      super.desconto = value;
    });
  }

  late final _$totalPedidoAtom =
      Atom(name: '_DadosPedidoStoreBase.totalPedido', context: context);

  @override
  double get totalPedido {
    _$totalPedidoAtom.reportRead();
    return super.totalPedido;
  }

  @override
  set totalPedido(double value) {
    _$totalPedidoAtom.reportWrite(value, super.totalPedido, () {
      super.totalPedido = value;
    });
  }

  late final _$totalProdAtom =
      Atom(name: '_DadosPedidoStoreBase.totalProd', context: context);

  @override
  double get totalProd {
    _$totalProdAtom.reportRead();
    return super.totalProd;
  }

  @override
  set totalProd(double value) {
    _$totalProdAtom.reportWrite(value, super.totalProd, () {
      super.totalProd = value;
    });
  }

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
  void removerProd(Produto produto) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.removerProd');
    try {
      return super.removerProd(produto);
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
descPorcent: ${descPorcent},
descReal: ${descReal},
desconto: ${desconto},
totalPedido: ${totalPedido},
totalProd: ${totalProd},
pedido: ${pedido},
edit: ${edit},
listaProdutos: ${listaProdutos}
    ''';
  }
}
