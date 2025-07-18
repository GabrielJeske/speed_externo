import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/funcoes/date.dart';
import 'package:speed_externo/funcoes/validate.dart';
import 'package:speed_externo/stores/faturamento_controller.dart';

part 'pedido_controller.g.dart';


class PedidoStore =_PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store{

                      
  TextEditingController controllerCliente = TextEditingController();
  TextEditingController controllerData = TextEditingController( text: Data.getData);
  TextEditingController controllerTipo = TextEditingController();
  
  @observable
  Pedido pedido = Pedido(listProd: []);

  @observable
  String tipoSelecionado = '1 - A Vista';

  @computed
  bool get isAPrazo => tipoSelecionado == '2 - A Prazo';


  @observable
  ObservableMap<String, String?> formErrors = ObservableMap.of({
  });

  @action
  void setTipo(String novoValor) {
     final faturamento = Get.find<FaturamentoController>();

    faturamento.resetFaturamento();
    tipoSelecionado = novoValor;
  }
 
 

 @action
  void setField(String chave, dynamic value){
    switch (chave) {      
      case tipoPed:    
      setTipo(value);   
      pedido = pedido.copyWith(tipo: int.tryParse(value)) ;
      case 'nome':
      controllerCliente.text = value;   
      case codClientePed:
      pedido = pedido.copyWith(codClie: int.tryParse(value)) ;   
    }
    Get.find<Validate>().validateField(chave, value); 
  }


    @action
  void validateAllFields(){ 
    Get.find<Validate>().validateAllFields;
  }

  @action
  void resetClie() {
    controllerCliente.text = '';  
  }
  
  @action
  void resetForm() {
    controllerCliente.text = '';
    controllerTipo.text = '';
    controllerData = TextEditingController( text: Data.getData);
    pedido = Pedido(listProd: []);
    setTipo('1 - A Vista');
  }

}