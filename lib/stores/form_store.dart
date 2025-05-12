import 'dart:developer';

import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'form_store.g.dart';


class FormStore =_FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store{

     
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
    formValues.clear();
    formErrors.clear();
  }

}