import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'cliente_controller.g.dart';


class FormStore =_FormStoreBase with _$FormStore;

abstract class _FormStoreBase with Store{


  TextEditingController controllerRazao = TextEditingController();
  TextEditingController controllerFantasia = TextEditingController();
  TextEditingController controllerCnpj = TextEditingController();
  TextEditingController controllerIe = TextEditingController();
  TextEditingController controllerEndereco = TextEditingController();
  TextEditingController controllerBairro = TextEditingController();
  TextEditingController controllerCep = TextEditingController();
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerContato = TextEditingController();
  TextEditingController controllerNumeroContato = TextEditingController();

  @observable
  Cliente cliente = Cliente();

  @observable
  ObservableMap<String, String?> formErrors = ObservableMap.of({});


  @computed
  bool get isFormValid => formErrors.values.every((error) => error == null);

 @action
  void setField(String chave, String value){
    switch (chave) {
      case id:
      cliente = cliente.copyWith(id: value) ;
      case nome:
      cliente = cliente.copyWith(nome: value) ;
      case razaosocial:
      cliente = cliente.copyWith(razaosocial: value) ;
      case fantasia:
      cliente = cliente.copyWith(fantasia: value) ;
      case cnpj:
      cliente = cliente.copyWith(cnpj: value) ;
      case ie:
      cliente = cliente.copyWith(ie: value) ;
      case endereco:
      cliente = cliente.copyWith(endereco: value) ;
      cliente = cliente.copyWith(bairro: value) ;
      case cep:
      cliente = cliente.copyWith(cep: value) ;
      case email:
      cliente = cliente.copyWith(email: value) ;
      case contato:
      cliente = cliente.copyWith(contato: value) ;
      case numeroContato:
      cliente = cliente.copyWith(numeroContato: value) ;
      case contribuinte:
      cliente = cliente.copyWith(contribuinte: value) ;
    }
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
    controllerIe.text = '';
    controllerEndereco.text = '';
    controllerBairro.text = '';
    controllerCep.text = '';
    controllerEmail.text = '';
    controllerContato.text = '';
    controllerNumeroContato.text = ''; 
    cliente = Cliente();
    formErrors.clear();
  }

}