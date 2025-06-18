import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/objetos/pedido.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'pedido_controller.g.dart';


class PedidoStore =_PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store{


  TextEditingController controllerCliente = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  
  @observable
  Pedido pedido = Pedido(listProd: []);

  @observable
  String tipoSelecionado = 'A Vista';

  @computed
  bool get isAPrazo => tipoSelecionado == 'A Prazo';


  @observable
  ObservableMap<String, String?> formErrors = ObservableMap.of({
  });

  @action
  void setTipo(String novoValor) {
    tipoSelecionado = novoValor;
  }
  @computed
  bool get isFormValid => formErrors.values.every((error) => error == null);
   
 

 @action
  void setField(String chave, String value){
    switch (chave) {
      case 'cliente':
      pedido = pedido.copyWith(codClie: value) ;      
      case 'data':
      pedido = pedido.copyWith(data: value) ;
      case 'tipo':    
      setTipo(value);   
      pedido = pedido.copyWith(tipo: value) ;
      case 'nome':
      controllerCliente.text = value;      
    }
    Get.find<ValidateStore>().validateField(chave, value); 
  }


    @action
  void validateAllFields(){ 
    Get.find<ValidateStore>().validateAllFields;
  }

  @action
  void resetForm() {
    controllerCliente.text = '';
    controllerTipo.text = '';
    controllerData.text = '';  
    pedido = Pedido(listProd: []);
    formErrors.clear();
     setTipo('A Vista');
  }

}