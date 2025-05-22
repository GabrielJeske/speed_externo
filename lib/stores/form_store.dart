import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'form_store.g.dart';


class FormStore =_FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store{


  TextEditingController controllerRazao = TextEditingController();
  TextEditingController controllerFantasia = TextEditingController();
  TextEditingController controllerCnpj = TextEditingController();
  TextEditingController controllerNome = TextEditingController();
  TextEditingController controllerCpf = TextEditingController();
  TextEditingController controllerIe = TextEditingController();
  TextEditingController controllerEndereco = TextEditingController();
  TextEditingController controllerNumero = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerCep = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerContato = TextEditingController();
  TextEditingController controllerNumeroContato = TextEditingController();
     
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
  void validateAllFields(String tipo) { // tipo pode ser 'pf' ou 'pj'
    log('Chamou ValidadeAll');
    Get.find<ValidateStore>().validateAllFields(tipo);
  }

  @action
  void resetForm() {
    controllerRazao.text = '';
    controllerFantasia.text = '';
    controllerCnpj.text = '';
    controllerNome.text = '';
    controllerCpf.text = '';
    controllerIe.text = '';
    controllerEndereco.text = '';
    controllerNumero.text = '';
    controllerBairro.text = '';
    controllerCep.text = '';
    controllerEmail.text = '';
    controllerContato.text = '';
    controllerNumeroContato.text = ''; 
    formValues.clear();
    formErrors.clear();
  }

}