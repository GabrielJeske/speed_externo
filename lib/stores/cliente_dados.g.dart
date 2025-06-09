// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosStore on _DadosStoreBase, Store {
  Computed<List<Cliente>>? _$listaFiltradaComputed;

  @override
  List<Cliente> get listaFiltrada => (_$listaFiltradaComputed ??=
          Computed<List<Cliente>>(() => super.listaFiltrada,
              name: '_DadosStoreBase.listaFiltrada'))
      .value;

  late final _$listaClientesAtom =
      Atom(name: '_DadosStoreBase.listaClientes', context: context);

  @override
  ObservableList<Cliente> get listaClientes {
    _$listaClientesAtom.reportRead();
    return super.listaClientes;
  }

  @override
  set listaClientes(ObservableList<Cliente> value) {
    _$listaClientesAtom.reportWrite(value, super.listaClientes, () {
      super.listaClientes = value;
    });
  }

  late final _$filtroAtom =
      Atom(name: '_DadosStoreBase.filtro', context: context);

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
      Atom(name: '_DadosStoreBase.clienSele', context: context);

  @override
  Cliente get clienSele {
    _$clienSeleAtom.reportRead();
    return super.clienSele;
  }

  @override
  set clienSele(Cliente value) {
    _$clienSeleAtom.reportWrite(value, super.clienSele, () {
      super.clienSele = value;
    });
  }

  late final _$exibeListaClienteAtom =
      Atom(name: '_DadosStoreBase.exibeListaCliente', context: context);

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
      AsyncAction('_DadosStoreBase.obtemClientes', context: context);

  @override
  Future<dynamic> obtemClientes() {
    return _$obtemClientesAsyncAction.run(() => super.obtemClientes());
  }

  late final _$_DadosStoreBaseActionController =
      ActionController(name: '_DadosStoreBase', context: context);

  @override
  void setFiltro(String filter) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.setFiltro');
    try {
      return super.setFiltro(filter);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCliente(Cliente cliente) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.setCliente');
    try {
      return super.setCliente(cliente);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaCliente(bool value) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.setListaCliente');
    try {
      return super.setListaCliente(value);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selecionarCliente(Cliente clienteSelecionado, String tipo) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.selecionarCliente');
    try {
      return super.selecionarCliente(clienteSelecionado, tipo);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaClientes: ${listaClientes},
filtro: ${filtro},
clienSele: ${clienSele},
exibeListaCliente: ${exibeListaCliente},
listaFiltrada: ${listaFiltrada}
    ''';
  }
}
