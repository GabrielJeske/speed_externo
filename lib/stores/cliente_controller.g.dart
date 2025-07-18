// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClienteController on ClienteControllerBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: 'ClienteControllerBase.isFormValid'))
          .value;

  late final _$clienteAtom =
      Atom(name: 'ClienteControllerBase.cliente', context: context);

  @override
  Cliente get cliente {
    _$clienteAtom.reportRead();
    return super.cliente;
  }

  @override
  set cliente(Cliente value) {
    _$clienteAtom.reportWrite(value, super.cliente, () {
      super.cliente = value;
    });
  }

  late final _$contribuitePadraoAtom =
      Atom(name: 'ClienteControllerBase.contribuitePadrao', context: context);

  @override
  String get contribuitePadrao {
    _$contribuitePadraoAtom.reportRead();
    return super.contribuitePadrao;
  }

  @override
  set contribuitePadrao(String value) {
    _$contribuitePadraoAtom.reportWrite(value, super.contribuitePadrao, () {
      super.contribuitePadrao = value;
    });
  }

  late final _$formErrorsAtom =
      Atom(name: 'ClienteControllerBase.formErrors', context: context);

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

  late final _$ClienteControllerBaseActionController =
      ActionController(name: 'ClienteControllerBase', context: context);

  @override
  void setField(String chave, dynamic value) {
    final _$actionInfo = _$ClienteControllerBaseActionController.startAction(
        name: 'ClienteControllerBase.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$ClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAllFields() {
    final _$actionInfo = _$ClienteControllerBaseActionController.startAction(
        name: 'ClienteControllerBase.validateAllFields');
    try {
      return super.validateAllFields();
    } finally {
      _$ClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$ClienteControllerBaseActionController.startAction(
        name: 'ClienteControllerBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$ClienteControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
cliente: ${cliente},
contribuitePadrao: ${contribuitePadrao},
formErrors: ${formErrors},
isFormValid: ${isFormValid}
    ''';
  }
}
