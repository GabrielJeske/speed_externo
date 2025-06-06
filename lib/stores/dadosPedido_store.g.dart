// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dadosPedido_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosPedidoStore on _DadosPedidoStoreBase, Store {
  Computed<List<Map<String, dynamic>>>? _$listaFiltradaComputed;

  @override
  List<Map<String, dynamic>> get listaFiltrada => (_$listaFiltradaComputed ??=
          Computed<List<Map<String, dynamic>>>(() => super.listaFiltrada,
              name: '_DadosPedidoStoreBase.listaFiltrada'))
      .value;

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

  late final _$listaClientesAtom =
      Atom(name: '_DadosPedidoStoreBase.listaClientes', context: context);

  @override
  ObservableList<Map<String, dynamic>> get listaClientes {
    _$listaClientesAtom.reportRead();
    return super.listaClientes;
  }

  @override
  set listaClientes(ObservableList<Map<String, dynamic>> value) {
    _$listaClientesAtom.reportWrite(value, super.listaClientes, () {
      super.listaClientes = value;
    });
  }

  late final _$filtroAtom =
      Atom(name: '_DadosPedidoStoreBase.filtro', context: context);

  @override
  String get filtro {
    _$filtroAtom.reportRead();
    return super.filtro;
  }

  @override
  set filtro(String value) {
    _$filtroAtom.reportWrite(value, super.filtro, () {
      super.filtro = value;
    });
  }

  late final _$clienSeleAtom =
      Atom(name: '_DadosPedidoStoreBase.clienSele', context: context);

  @override
  Map<String, dynamic> get clienSele {
    _$clienSeleAtom.reportRead();
    return super.clienSele;
  }

  @override
  set clienSele(Map<String, dynamic> value) {
    _$clienSeleAtom.reportWrite(value, super.clienSele, () {
      super.clienSele = value;
    });
  }

  late final _$exibeListaClienteAtom =
      Atom(name: '_DadosPedidoStoreBase.exibeListaCliente', context: context);

  @override
  bool get exibeListaCliente {
    _$exibeListaClienteAtom.reportRead();
    return super.exibeListaCliente;
  }

  @override
  set exibeListaCliente(bool value) {
    _$exibeListaClienteAtom.reportWrite(value, super.exibeListaCliente, () {
      super.exibeListaCliente = value;
    });
  }

  late final _$obtemClientesAsyncAction =
      AsyncAction('_DadosPedidoStoreBase.obtemClientes', context: context);

  @override
  Future<dynamic> obtemClientes() {
    return _$obtemClientesAsyncAction.run(() => super.obtemClientes());
  }

  late final _$_DadosPedidoStoreBaseActionController =
      ActionController(name: '_DadosPedidoStoreBase', context: context);

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
  void setFiltro(String filter) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.setFiltro');
    try {
      return super.setFiltro(filter);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCliente(Map<String, dynamic> cliente) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.setCliente');
    try {
      return super.setCliente(cliente);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaCliente(bool value) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.setListaCliente');
    try {
      return super.setListaCliente(value);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selecionarCliente(Map<String, dynamic> clienteSelecionado, String tipo) {
    final _$actionInfo = _$_DadosPedidoStoreBaseActionController.startAction(
        name: '_DadosPedidoStoreBase.selecionarCliente');
    try {
      return super.selecionarCliente(clienteSelecionado, tipo);
    } finally {
      _$_DadosPedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaProdutos: ${listaProdutos},
listaClientes: ${listaClientes},
filtro: ${filtro},
clienSele: ${clienSele},
exibeListaCliente: ${exibeListaCliente},
listaFiltrada: ${listaFiltrada}
    ''';
  }
}
