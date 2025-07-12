import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/cliente.dart';
import 'package:speed_externo/funcoes/validate.dart';

part 'cliente_controller.g.dart';


class ClienteController =ClienteControllerBase with _$ClienteController;

abstract class ClienteControllerBase with Store{


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
  Cliente cliente = Cliente(contribuinte: '9');

  @observable
  String contribuitePadrao = contribuinte9;

  @observable
  ObservableMap<String, String?> formErrors = ObservableMap.of({});


  @computed
  bool get isFormValid => formErrors.values.every((error) => error == null);

 @action
  void setField(String chave, String value){
    switch (chave) {
      case razaosocial:
      cliente = cliente.copyWith(razaosocial: value) ;
      break;
      case fantasia:
      cliente = cliente.copyWith(fantasia: value) ;
      break;
      case cnpj:
      cliente = cliente.copyWith(cnpj: value) ;
      break;
      case cpf:
      cliente = cliente.copyWith(cnpj: value) ;
      break;
      case ie:
      cliente = cliente.copyWith(ie: value) ;
      break;
      case endereco:
      cliente = cliente.copyWith(endereco: value) ;
      break;
      case cep:
      cliente = cliente.copyWith(cep: value) ;
      break;
      case email:
      cliente = cliente.copyWith(email: value) ;
      break;
      case contato:
      cliente = cliente.copyWith(contato: value) ;
      break;
      case numeroContato:
      cliente = cliente.copyWith(numeroContato: value) ;
      break;
      case contribuinte:
      cliente = cliente.copyWith(contribuinte: value) ;
      Get.find<Validate>().validateField(ie, cliente.ie ?? '');
      break;
    }
    Get.find<Validate>().validateField(chave, value);
  }

    @action
  void validateAllFields() {
    Get.find<Validate>().validateAllFields();
  }

  @action
  void resetForm() {
    contribuitePadrao = contribuinte9;
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