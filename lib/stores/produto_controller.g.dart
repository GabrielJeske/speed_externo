// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ProdutoFormStore on _ProdutoFormStoreBase, Store {
  Computed<bool>? _$isFormValidComputed;

  @override
  bool get isFormValid =>
      (_$isFormValidComputed ??= Computed<bool>(() => super.isFormValid,
              name: '_ProdutoFormStoreBase.isFormValid'))
          .value;

  late final _$prodAtom =
      Atom(name: '_ProdutoFormStoreBase.prod', context: context);

  @override
  Produto get prod {
    _$prodAtom.reportRead();
    return super.prod;
  }

  @override
  set prod(Produto value) {
    _$prodAtom.reportWrite(value, super.prod, () {
      super.prod = value;
    });
  }

  late final _$prodErrorsAtom =
      Atom(name: '_ProdutoFormStoreBase.prodErrors', context: context);

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

  late final _$_ProdutoFormStoreBaseActionController =
      ActionController(name: '_ProdutoFormStoreBase', context: context);

  @override
  void setField(String chave, String value) {
    final _$actionInfo = _$_ProdutoFormStoreBaseActionController.startAction(
        name: '_ProdutoFormStoreBase.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$_ProdutoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void validateAllFields(String tipo) {
    final _$actionInfo = _$_ProdutoFormStoreBaseActionController.startAction(
        name: '_ProdutoFormStoreBase.validateAllFields');
    try {
      return super.validateAllFields(tipo);
    } finally {
      _$_ProdutoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetForm() {
    final _$actionInfo = _$_ProdutoFormStoreBaseActionController.startAction(
        name: '_ProdutoFormStoreBase.resetForm');
    try {
      return super.resetForm();
    } finally {
      _$_ProdutoFormStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
prod: ${prod},
prodErrors: ${prodErrors},
isFormValid: ${isFormValid}
    ''';
  }
}
