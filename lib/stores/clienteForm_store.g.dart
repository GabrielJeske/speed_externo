// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'clienteForm_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ClienteFormStore on _ClienteFormStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ClienteFormStoreBase.isFormValid'))
          .value;

  late final _$prodValuesAtom =
      Atom(name: '_ClienteFormStoreBase.prodValues', context: context);

  @override
  ObservableMap<String, String> get prodValues {
    _$prodValuesAtom.reportRead();
    return super.prodValues;
  }

  @override
  set prodValues(ObservableMap<String, String> value) {
    _$prodValuesAtom.reportWrite(value, super.prodValues, () {
      super.prodValues = value;
    });
  }

  late final _$prodErrorsAtom =
      Atom(name: '_ClienteFormStoreBase.prodErrors', context: context);

  @override
  ObservableMap<String, String?> get prodErrors {
    _$prodErrorsAtom.reportRead();
    return super.prodErrors;
  }

  @override
  set prodErrors(ObservableMap<String, String?> value) {
    _$prodErrorsAtom.reportWrite(value, super.prodErrors, () {
      super.prodErrors = value;
    });
  }

  late final _$_ClienteFormStoreBaseActionController =
      ActionController(name: '_ClienteFormStoreBase', context: context);

  @override
  void setField(String chave, String value) {
    final _$actionInfo = _$_ClienteFormStoreBaseActionController.startAction(
        name: '_ClienteFormStoreBase.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$_ClienteFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAllFields(String tipo) {
    final _$actionInfo = _$_ClienteFormStoreBaseActionController.startAction(
        name: '_ClienteFormStoreBase.validateAllFields');
    try {
      return super.validateAllFields(tipo);
    } finally {
      _$_ClienteFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_ClienteFormStoreBaseActionController.startAction(
        name: '_ClienteFormStoreBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_ClienteFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
prodValues: ${prodValues},
prodErrors: ${prodErrors},
isFormValid: ${isFormValid}
    ''';
  }
}
