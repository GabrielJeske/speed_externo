// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'form_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FormStore on _FormStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_FormStoreBase.isFormValid'))
          .value;

  late final _$formValuesAtom =
      Atom(name: '_FormStoreBase.formValues', context: context);

  @override
  ObservableMap<String, String> get formValues {
    _$formValuesAtom.reportRead();
    return super.formValues;
  }

  @override
  set formValues(ObservableMap<String, String> value) {
    _$formValuesAtom.reportWrite(value, super.formValues, () {
      super.formValues = value;
    });
  }

  late final _$formErrorsAtom =
      Atom(name: '_FormStoreBase.formErrors', context: context);

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

  late final _$_FormStoreBaseActionController =
      ActionController(name: '_FormStoreBase', context: context);

  @override
  void setField(String chave, String value) {
    final _$actionInfo = _$_FormStoreBaseActionController.startAction(
        name: '_FormStoreBase.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$_FormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_FormStoreBaseActionController.startAction(
        name: '_FormStoreBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_FormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateField(String chave, String value) {
    final _$actionInfo = _$_FormStoreBaseActionController.startAction(
        name: '_FormStoreBase.validateField');
    try {
      return super.validateField(chave, value);
    } finally {
      _$_FormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAllFields(String tipo) {
    final _$actionInfo = _$_FormStoreBaseActionController.startAction(
        name: '_FormStoreBase.validateAllFields');
    try {
      return super.validateAllFields(tipo);
    } finally {
      _$_FormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAll() {
    final _$actionInfo = _$_FormStoreBaseActionController.startAction(
        name: '_FormStoreBase.validateAll');
    try {
      return super.validateAll();
    } finally {
      _$_FormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
formValues: ${formValues},
formErrors: ${formErrors},
isFormValid: ${isFormValid}
    ''';
  }
}
