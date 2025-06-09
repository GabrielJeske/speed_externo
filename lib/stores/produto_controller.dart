import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/stores/validate_store.dart';

part 'produto_controller.g.dart';


class ProdutoFormStore =_ProdutoFormStoreBase with _$ProdutoFormStore;

abstract class _ProdutoFormStoreBase with Store{

  TextEditingController controllerCod = TextEditingController();
  TextEditingController controllerNomeProd = TextEditingController();
  TextEditingController controllerNcm = TextEditingController();
  TextEditingController controllerUnidade = TextEditingController();
  TextEditingController controllerMarca = TextEditingController();
  TextEditingController controllerApre = TextEditingController();
  TextEditingController controllerGrupo1 = TextEditingController();
  TextEditingController controllerGrupo2 = TextEditingController();
  TextEditingController controllerGrupo3 = TextEditingController();
  TextEditingController controllerCst = TextEditingController();
  TextEditingController controllerCusto = TextEditingController();
  TextEditingController controllerFabrica = TextEditingController();
  TextEditingController controllerVenda = TextEditingController();
  TextEditingController controllerEstAtual = TextEditingController();
  TextEditingController controllerEstParcial = TextEditingController();
  TextEditingController controllerUnit = TextEditingController();
  TextEditingController controllerTotal = TextEditingController();
  TextEditingController controllerQuant = TextEditingController();

  @observable
  Produto prod = Produto();

  @observable
  ObservableMap<String, String?> prodErrors = ObservableMap.of({
  });

  @computed
  bool get isFormValid => prodErrors.values.every((error) => error == null);

  @action
  void setField(String chave, String value){
    switch (chave) {
      case cod:
      prod = prod.copyWith(cod: value) ;
      case nome:
      prod = prod.copyWith(nome: value) ;
      case ncm:
      prod = prod.copyWith(ncm: value) ;
      case unidade:
      prod = prod.copyWith(unidade: value) ;
      case marca:
      prod = prod.copyWith(marca: value) ;
      case apresentacao:
      prod = prod.copyWith(apresentacao: value) ;
      case grupo1:
      prod = prod.copyWith(grupo1: value) ;
      case grupo2:
      prod = prod.copyWith(grupo2: value) ;
      case grupo3:
      prod = prod.copyWith(grupo3: value) ;
      case cst:
      prod = prod.copyWith(cst: value) ;
      case custo:
      prod = prod.copyWith(custo: value) ;
      case fabrica:
      prod = prod.copyWith(fabrica: value) ;
      case venda:
      prod = prod.copyWith(venda: value) ;
      case estoqueatual:
      prod = prod.copyWith(estoqueatual: value) ;
      case estoqueparcial:
      prod = prod.copyWith(estoqueparcial: value) ;
      case quantidade:
      prod = prod.copyWith(quantidade: value) ;
      case unitario:
      prod = prod.copyWith(unitario: value) ;
      case total:
      prod = prod.copyWith(total: value) ;

    }
    Get.find<ValidateStore>().validateField(chave, value);
  }

    @action
  void validateAllFields(String tipo) {
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
    controllerApre.text = '';
    controllerGrupo1.text = '';
    controllerGrupo2.text = '';
    controllerGrupo3.text = '';
    controllerCst.text = '';
    controllerCusto.text = '';
    controllerFabrica.text = '';
    controllerVenda.text = '';
    controllerEstAtual.text = '';
    controllerEstParcial.text = '';
    controllerQuant.text = '';
    controllerUnit.text = '';
    controllerTotal.text = '';

    prod = Produto();
    prodErrors.clear();
  }

}