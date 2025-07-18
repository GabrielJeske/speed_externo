import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/conta.dart';
import 'package:speed_externo/commom/objetos/faturamento.dart';
import 'package:speed_externo/stores/pedido_controller.dart';
import 'package:speed_externo/stores/pedido_dados.dart';

part 'faturamento_controller.g.dart';

class FaturamentoController = _FaturamentoController with _$FaturamentoController;

abstract class _FaturamentoController with Store {

  @observable
  Faturamento faturamento = Faturamento(contas: []);

  @observable
  double total = 0.0;

  @observable
  double entrada = 0.0;

  @observable
  int? parcelas;

  _FaturamentoController() {
    // Reaction para reagir a qualquer alteração nos campos
    reaction(
      (_) => [ total, entrada, parcelas, formaPagamento],
      (_) => geraContas(),
    );
  }


  @observable
  String formaPagamento = '';
  
 

  TextEditingController entradaController = TextEditingController();
  TextEditingController parcelasController = TextEditingController();
  TextEditingController tipoController = TextEditingController();

  @action
  void setField(String chave, String value) {
    switch (chave) {     
      case 'parcelas':
        parcelas = int.tryParse(value) ?? 0;
        faturamento = faturamento.copyWith(parcelas: parcelas);
        break;
      case 'entrada':
        entrada = double.tryParse(value) ?? 0.0;
        break;
      case 'formaPagamento':
        formaPagamento = value;
        tipoController.text = formaPagamento;
        break;
      default:
        throw Exception('Campo desconhecido: $chave');
    }
  }

  @action
  void geraContas() {
    faturamento.contas.clear();
     final pedido = Get.find<DadosPedidoStore>();
     final pedidoController = Get.find<PedidoStore>();
     total = pedido.totalPedido - entrada;
     if (pedidoController.pedido.tipo == 'A Prazo') {
       if (entrada > 0.0) {
     faturamento.contas.add(Conta(
        id: 1,
        valor: entrada,
        vencimento: DateTime.now(),
        formaPagamento: formaPagamento,
      ));
     }     
    if (faturamento.parcelas != null && faturamento.parcelas! > 0) {
      for (int i = 1; i < faturamento.parcelas!; i++) {      
        faturamento.contas.add(Conta(
        id: i +1,
        valor: total / faturamento.parcelas!,
        vencimento: DateTime.now().add(Duration(days: 30 * i)),
        formaPagamento: formaPagamento,
      ));
    }
      } 
     } else {
        faturamento.contas.add(Conta(
        id: 1,
        valor: total,
        vencimento: DateTime.now(),
        formaPagamento: formaPagamento,
      ));
     }
      faturamento = faturamento.copyWith(contas: faturamento.contas); 
    
  }
   @action
  void salvarFaturamento() {
    faturamento = faturamento.copyWith(    
      parcelas: parcelas, 
      contas: faturamento.contas.toList(),
    );
  }
  @action
  void resetFaturamento(){
    formaPagamento = '';  
    entrada = 0;
    entradaController.text = '';
    parcelasController.text = '';
    tipoController.text = '';
    faturamento = Faturamento(contas: []);
  }

}