// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClienteDados on ClienteDadosBase, Store {
  Computed<List<Cliente>>? _$listaFiltradaComputed;

  @override
  List<Cliente> get listaFiltrada => (_$listaFiltradaComputed ??=
          Computed<List<Cliente>>(() => super.listaFiltrada,
              name: 'ClienteDadosBase.listaFiltrada'))
      .value;

  late final _$exibeListaClienteAtom =
      Atom(name: 'ClienteDadosBase.exibeListaCliente', context: context);

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

  late final _$listaClientesAtom =
      Atom(name: 'ClienteDadosBase.listaClientes', context: context);

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
      Atom(name: 'ClienteDadosBase.filtro', context: context);

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
      Atom(name: 'ClienteDadosBase.clienSele', context: context);

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

  late final _$obtemClientesAsyncAction =
      AsyncAction('ClienteDadosBase.obtemClientes', context: context);

  @override
  Future<void> obtemClientes() {
    return _$obtemClientesAsyncAction.run(() => super.obtemClientes());
  }

  late final _$ClienteDadosBaseActionController =
      ActionController(name: 'ClienteDadosBase', context: context);

  @override
  void setListaCliente(bool value) {
    final _$actionInfo = _$ClienteDadosBaseActionController.startAction(
        name: 'ClienteDadosBase.setListaCliente');
    try {
      return super.setListaCliente(value);
    } finally {
      _$ClienteDadosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setFiltro(String filter) {
    final _$actionInfo = _$ClienteDadosBaseActionController.startAction(
        name: 'ClienteDadosBase.setFiltro');
    try {
      return super.setFiltro(filter);
    } finally {
      _$ClienteDadosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setCliente(Cliente cliente) {
    final _$actionInfo = _$ClienteDadosBaseActionController.startAction(
        name: 'ClienteDadosBase.setCliente');
    try {
      return super.setCliente(cliente);
    } finally {
      _$ClienteDadosBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
exibeListaCliente: ${exibeListaCliente},
listaClientes: ${listaClientes},
filtro: ${filtro},
clienSele: ${clienSele},
listaFiltrada: ${listaFiltrada}
    ''';
  }
}
