// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_dados.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$DadosProdutoStore on _DadosProdutoStoreBase, Store {
  Computed<List<Produto>>? _$listaFiltradaComputed;

  @override
  List<Produto> get listaFiltrada => (_$listaFiltradaComputed ??=
          Computed<List<Produto>>(() => super.listaFiltrada,
              name: '_DadosProdutoStoreBase.listaFiltrada'))
      .value;

  late final _$listaProdutosAtom =
      Atom(name: '_DadosProdutoStoreBase.listaProdutos', context: context);

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

  late final _$filtroProdAtom =
      Atom(name: '_DadosProdutoStoreBase.filtroProd', context: context);

  @override
  String get filtroProd {
    _$filtroProdAtom.reportRead();
    return super.filtroProd;
  }

  @override
  set filtroProd(String value) {
    _$filtroProdAtom.reportWrite(value, super.filtroProd, () {
      super.filtroProd = value;
    });
  }

  late final _$prodSeleAtom =
      Atom(name: '_DadosProdutoStoreBase.prodSele', context: context);

  @override
  Produto get prodSele {
    _$prodSeleAtom.reportRead();
    return super.prodSele;
  }

  @override
  set prodSele(Produto value) {
    _$prodSeleAtom.reportWrite(value, super.prodSele, () {
      super.prodSele = value;
    });
  }

  late final _$exibeListaProdAtom =
      Atom(name: '_DadosProdutoStoreBase.exibeListaProd', context: context);

  @override
  bool get exibeListaProd {
    _$exibeListaProdAtom.reportRead();
    return super.exibeListaProd;
  }

  @override
  set exibeListaProd(bool value) {
    _$exibeListaProdAtom.reportWrite(value, super.exibeListaProd, () {
      super.exibeListaProd = value;
    });
  }

  late final _$obtemProdutosAsyncAction =
      AsyncAction('_DadosProdutoStoreBase.obtemProdutos', context: context);

  @override
  Future<void> obtemProdutos() {
    return _$obtemProdutosAsyncAction.run(() => super.obtemProdutos());
  }

  late final _$_DadosProdutoStoreBaseActionController =
      ActionController(name: '_DadosProdutoStoreBase', context: context);

  @override
  void setFiltroProd(String filter) {
    final _$actionInfo = _$_DadosProdutoStoreBaseActionController.startAction(
        name: '_DadosProdutoStoreBase.setFiltroProd');
    try {
      return super.setFiltroProd(filter);
    } finally {
      _$_DadosProdutoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setProduto(Produto prod) {
    final _$actionInfo = _$_DadosProdutoStoreBaseActionController.startAction(
        name: '_DadosProdutoStoreBase.setProduto');
    try {
      return super.setProduto(prod);
    } finally {
      _$_DadosProdutoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setListaProd(bool value) {
    final _$actionInfo = _$_DadosProdutoStoreBaseActionController.startAction(
        name: '_DadosProdutoStoreBase.setListaProd');
    try {
      return super.setListaProd(value);
    } finally {
      _$_DadosProdutoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void selecionarProd(Produto produtoSelecionado) {
    final _$actionInfo = _$_DadosProdutoStoreBaseActionController.startAction(
        name: '_DadosProdutoStoreBase.selecionarProd');
    try {
      return super.selecionarProd(produtoSelecionado);
    } finally {
      _$_DadosProdutoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listaProdutos: ${listaProdutos},
filtroProd: ${filtroProd},
prodSele: ${prodSele},
exibeListaProd: ${exibeListaProd},
listaFiltrada: ${listaFiltrada}
    ''';
  }
}
