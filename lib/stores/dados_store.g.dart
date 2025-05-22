// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dados_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosStore on _DadosStoreBase, Store {
  Computed<List<Map<String, dynamic>>>? _$listaFiltradaComputed;

  @override
  List<Map<String, dynamic>> get listaFiltrada => (_$listaFiltradaComputed ??=
          Computed<List<Map<String, dynamic>>>(() => super.listaFiltrada,
              name: '_DadosStoreBase.listaFiltrada'))
      .value;

  late final _$listaClientesAtom =
      Atom(name: '_DadosStoreBase.listaClientes', context: context);

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

  late final _$showSuggestionsAtom =
      Atom(name: '_DadosStoreBase.showSuggestions', context: context);

  @override
  bool get showSuggestions {
    _$showSuggestionsAtom.reportRead();
    return super.showSuggestions;
  }

  @override
  set showSuggestions(bool value) {
    _$showSuggestionsAtom.reportWrite(value, super.showSuggestions, () {
      super.showSuggestions = value;
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
  void setCliente(Map<String, dynamic> cliente) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.setCliente');
    try {
      return super.setCliente(cliente);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setShowSuggestions(bool value) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.setShowSuggestions');
    try {
      return super.setShowSuggestions(value);
    } finally {
      _$_DadosStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selecionarCliente(Map<String, dynamic> clienteSelecionado) {
    final _$actionInfo = _$_DadosStoreBaseActionController.startAction(
        name: '_DadosStoreBase.selecionarCliente');
    try {
      return super.selecionarCliente(clienteSelecionado);
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
showSuggestions: ${showSuggestions},
listaFiltrada: ${listaFiltrada}
    ''';
  }
}
