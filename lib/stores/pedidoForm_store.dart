import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'pedidoForm_store.g.dart';


class PedidoStore =_PedidoStoreBase with _$PedidoStore;

abstract class _PedidoStoreBase with Store{


  TextEditingController controllerCliente = TextEditingController();
  TextEditingController controllerData = TextEditingController();
  TextEditingController controllerTipo = TextEditingController();
  
  @observable
  


   @observable
   ObservableMap<String, String> formValues = ObservableMap.of({});


   @observable
   ObservableMap<String, String?> formErrors = ObservableMap.of({
   });


   @computed
   bool get isFormValid => formErrors.values.every((error) => error == null);



   @action
   void setField(String chave, String value){
      formValues[chave]=value;
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
    formValues.clear();
    formErrors.clear();
  }

}