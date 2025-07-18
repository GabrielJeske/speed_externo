// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faturamento_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FaturamentoController on _FaturamentoController, Store {
  late final _$faturamentoAtom =
      Atom(name: '_FaturamentoController.faturamento', context: context);

  @override
  Faturamento get faturamento {
    _$faturamentoAtom.reportRead();
    return super.faturamento;
  }

  @override
  set faturamento(Faturamento value) {
    _$faturamentoAtom.reportWrite(value, super.faturamento, () {
      super.faturamento = value;
    });
  }

  late final _$totalAtom =
      Atom(name: '_FaturamentoController.total', context: context);

  @override
  double get total {
    _$totalAtom.reportRead();
    return super.total;
  }

  @override
  set total(double value) {
    _$totalAtom.reportWrite(value, super.total, () {
      super.total = value;
    });
  }

  late final _$entradaAtom =
      Atom(name: '_FaturamentoController.entrada', context: context);

  @override
  double get entrada {
    _$entradaAtom.reportRead();
    return super.entrada;
  }

  @override
  set entrada(double value) {
    _$entradaAtom.reportWrite(value, super.entrada, () {
      super.entrada = value;
    });
  }

  late final _$parcelasAtom =
      Atom(name: '_FaturamentoController.parcelas', context: context);

  @override
  int? get parcelas {
    _$parcelasAtom.reportRead();
    return super.parcelas;
  }

  @override
  set parcelas(int? value) {
    _$parcelasAtom.reportWrite(value, super.parcelas, () {
      super.parcelas = value;
    });
  }

  late final _$formaPagamentoAtom =
      Atom(name: '_FaturamentoController.formaPagamento', context: context);

  @override
  String get formaPagamento {
    _$formaPagamentoAtom.reportRead();
    return super.formaPagamento;
  }

  @override
  set formaPagamento(String value) {
    _$formaPagamentoAtom.reportWrite(value, super.formaPagamento, () {
      super.formaPagamento = value;
    });
  }

  late final _$_FaturamentoControllerActionController =
      ActionController(name: '_FaturamentoController', context: context);

  @override
  void setField(String chave, String value) {
    final _$actionInfo = _$_FaturamentoControllerActionController.startAction(
        name: '_FaturamentoController.setField');
    try {
      return super.setField(chave, value);
    } finally {
      _$_FaturamentoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void geraContas() {
    final _$actionInfo = _$_FaturamentoControllerActionController.startAction(
        name: '_FaturamentoController.geraContas');
    try {
      return super.geraContas();
    } finally {
      _$_FaturamentoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void salvarFaturamento() {
    final _$actionInfo = _$_FaturamentoControllerActionController.startAction(
        name: '_FaturamentoController.salvarFaturamento');
    try {
      return super.salvarFaturamento();
    } finally {
      _$_FaturamentoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  void resetFaturamento() {
    final _$actionInfo = _$_FaturamentoControllerActionController.startAction(
        name: '_FaturamentoController.resetFaturamento');
    try {
      return super.resetFaturamento();
    } finally {
      _$_FaturamentoControllerActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
faturamento: ${faturamento},
total: ${total},
entrada: ${entrada},
parcelas: ${parcelas},
formaPagamento: ${formaPagamento}
    ''';
  }
}
