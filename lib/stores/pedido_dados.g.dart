// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosPedidoStore on _DadosPedidoStoreBase, Store {
  late final _$listaDePedidosAtom =
      Atom(name: '_DadosPedidoStoreBase.listaDePedidos', context: context);

  @override
  ObservableList<Pedido> get listaDePedidos {
    _$listaDePedidosAtom.reportRead();
    return super.listaDePedidos;
  }

  @override
  set listaDePedidos(ObservableList<Pedido> value) {
    _$listaDePedidosAtom.reportWrite(value, super.listaDePedidos, () {
      super.listaDePedidos = value;
    });
  }

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

  late final _$itemCountAtom =
      Atom(name: '_DadosPedidoStoreBase.itemCount', context: context);

  @override
  int get itemCount {
    _$itemCountAtom.reportRead();
    return super.itemCount;
  }

  @override
  set itemCount(int value) {
    _$itemCountAtom.reportWrite(value, super.itemCount, () {
      super.itemCount = value;
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

  late final _$prodRemovidoAtom =
      Atom(name: '_DadosPedidoStoreBase.prodRemovido', context: context);

  @override
  Produto? get prodRemovido {
    _$prodRemovidoAtom.reportRead();
    return super.prodRemovido;
  }

  @override
  set prodRemovido(Produto? value) {
    _$prodRemovidoAtom.reportWrite(value, super.prodRemovido, () {
      super.prodRemovido = value;
    });
  }

  late final _$obtemPedidosAsyncAction =
      AsyncAction('_DadosPedidoStoreBase.obtemPedidos', context: context);

  @override
  Future<dynamic> obtemPedidos() {
    return _$obtemPedidosAsyncAction.run(() => super.obtemPedidos());
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
  void desfazerRemocao() {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.desfazerRemocao');
    try {
      return super.desfazerRemocao();
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetPedido() {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.resetPedido');
    try {
      return super.resetPedido();
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaDePedidos: ${listaDePedidos},
descPorcent: ${descPorcent},
descReal: ${descReal},
desconto: ${desconto},
totalPedido: ${totalPedido},
totalProd: ${totalProd},
itemCount: ${itemCount},
edit: ${edit},
listaProdutos: ${listaProdutos},
prodRemovido: ${prodRemovido}
    ''';
  }
}
