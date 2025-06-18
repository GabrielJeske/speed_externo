import 'package:flutter/widgets.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/conta.dart';
import 'package:speed_externo/commom/objetos/faturamento.dart';

part 'faturamento_controller.g.dart';

class FaturamentoController = _FaturamentoController with _$FaturamentoController;

abstract class _FaturamentoController with Store {

  Faturamento faturamento = Faturamento();

  @observable
  List<Conta> contas = [];

  TextEditingController entradaController = TextEditingController();
  TextEditingController parcelasController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  @action
  void setField(String chave, String value) {
    switch (chave) {     
      case 'parcelas':
        int parcelas = int.tryParse(value) ?? 0;
        faturamento = faturamento.copyWith(parcelas: parcelas);
        break;
      case 'tipo':
        faturamento = faturamento.copyWith(tipo: value);
        break;
      default:
        throw Exception('Campo desconhecido: $chave');
    }
  }

  void addConta(Conta conta) {
    contas.add(conta);
    faturamento = faturamento.copyWith(contas: contas);
  }

  
}
