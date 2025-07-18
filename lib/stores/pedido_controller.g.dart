// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PedidoStore on _PedidoStoreBase, Store {
  Computed<bool>? _$isAPrazoComputed;

  @override
  bool get isAPrazo =>
      (_$isAPrazoComputed ??= Computed<bool>(() => super.isAPrazo,
              name: '_PedidoStoreBase.isAPrazo'))
          .value;

  late final _$pedidoAtom =
      Atom(name: '_PedidoStoreBase.pedido', context: context);

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

  late final _$tipoSelecionadoAtom =
      Atom(name: '_PedidoStoreBase.tipoSelecionado', context: context);

  @override
  String get tipoSelecionado {
    _$tipoSelecionadoAtom.reportRead();
    return super.tipoSelecionado;
  }

  @override
  set tipoSelecionado(String value) {
    _$tipoSelecionadoAtom.reportWrite(value, super.tipoSelecionado, () {
      super.tipoSelecionado = value;
    });
  }

  late final _$formErrorsAtom =
      Atom(name: '_PedidoStoreBase.formErrors', context: context);

  @override
  ObservableMap<String, String?> get formErrors {
    _$formErrorsAtom.reportRead();
    return super.formErrors;
  }

  @override
  set formErrors(ObservableMap<String, String?> value) {
    _$formErrorsAtom.reportWrite(value, super.formErrors, () {
      super.formErrors = value;
    });
  }

  late final _$_PedidoStoreBaseActionController =
      ActionController(name: '_PedidoStoreBase', context: context);

  @override
  void setTipo(String novoValor) {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.setTipo');
    try {
      return super.setTipo(novoValor);
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setField(String chave, dynamic value) {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAllFields() {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.validateAllFields');
    try {
      return super.validateAllFields();
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetClie() {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.resetClie');
    try {
      return super.resetClie();
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_PedidoStoreBaseActionController.startAction(
        name: '_PedidoStoreBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_PedidoStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
pedido: ${pedido},
tipoSelecionado: ${tipoSelecionado},
formErrors: ${formErrors},
isAPrazo: ${isAPrazo}
    ''';
  }
}
