import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'clienteForm_store.g.dart';


class ClienteFormStore =_ClienteFormStoreBase with _$ClienteFormStore;

abstract class _ClienteFormStoreBase with Store{


    String? cod;
  String? nome;
  String? ncm;
  String? un;
  String? marca;
  String? cst;
  String? custo;
  String? venda;

  TextEditingController controllerCod = TextEditingController();
  TextEditingController controllerNomeProd = TextEditingController();
  TextEditingController controllerNcm = TextEditingController();
  TextEditingController controllerUnidade = TextEditingController();
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerCst = TextEditingController();
  TextEditingController controllerCusto = TextEditingController();
  TextEditingController controllerVenda = TextEditingController();
     
   @observable
   ObservableMap<String, String> prodValues = ObservableMap.of({});


   @observable
   ObservableMap<String, String?> prodErrors = ObservableMap.of({
   });


   @computed
   bool get isFormValid => prodErrors.values.every((error) => error == null);



   @action
   void setField(String chave, String value){
      prodValues[chave]=value;
       Get.find<ValidateStore>().validateField(chave, value);
   }

    @action
  void validateAllFields(String tipo) { // tipo pode ser 'pf' ou 'pj'
    log('Chamou ValidadeAll');
    Get.find<ValidateStore>().validateAllFields(tipo);
  }

  @action
  void resetForm() {
    controllerCod.text = '';
    controllerNomeProd.text = '';
    controllerNcm.text = '';
    controllerUnidade.text = '';
    controllerMarca.text = '';
    controllerCst.text = '';
    controllerCusto.text = '';
    controllerVenda.text = '';

    prodValues.clear();
    prodErrors.clear();
  }

}