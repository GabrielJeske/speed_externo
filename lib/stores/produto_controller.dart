import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobx/mobx.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:speed_externo/funcoes/validate.dart';

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
  void setField(String chave, dynamic value){
    switch (chave) {
      case codProd:
      prod = prod.copyWith(cod: value) ;
      case nomeProd:
      prod = prod.copyWith(nome: value) ;
      case ncmProd:
      prod = prod.copyWith(ncm: value) ;
      case unidadeProd:
      prod = prod.copyWith(unidade: value) ;
      case marcaProd:
      prod = prod.copyWith(marca: value) ;
      case apresentProd:
      prod = prod.copyWith(apresentacao: value) ;
      case grupo1Prod:
      prod = prod.copyWith(grupo1: value) ;
      case grupo2Prod:
      prod = prod.copyWith(grupo2: value) ;
      case grupo3Prod:
      prod = prod.copyWith(grupo3: value) ;
      case cstProd:
      prod = prod.copyWith(cst: value) ;
      case custoProd:
      prod = prod.copyWith(custo: value) ;
      case fabricaProd:
      prod = prod.copyWith(fabrica: value) ;
      case vendaProd:
      prod = prod.copyWith(venda: value) ;
      case estqatualProd:
      prod = prod.copyWith(estoqueatual: value) ;
      case estqparcialProd:
      prod = prod.copyWith(estoqueparcial: value) ;
      case qtdProd:
      prod = prod.copyWith(quantidade: value) ;
      case unitarioProd:
      prod = prod.copyWith(unitario: value) ;
      case totalProd:
      prod = prod.copyWith(total: value) ;

    }
    Get.find<Validate>().validateField(chave, value);
  }

    @action
  void validateAllFields(String tipo) {
    Get.find<Validate>().validateAllFields();
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