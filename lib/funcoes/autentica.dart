import 'package:get/get.dart';
import 'dart:convert';
import 'dart:math';


class Autentica {

   static String mudaHexa(int pHexa) {
    var chave = "123456789ABCDEFGHIJKLMNOPQRSTUVXYZ";

    var retorno = pHexa == 0 ? "0" : chave[pHexa - 1];

    //print("retorno: [$retorno]");
    return retorno;
  }

  String login = '';
  String senha = '';

  void setField (String value, String chave){
    if (chave == 'login'){
      login = value;
    }else if (chave == 'senha'){
      senha = value;
    }
  }

  void fazLogin (){
    String pNum = login + senha;
    String hash = chkIdent(pNum);
    if (hash == 'JTDVHQQ'){
      Get.offAllNamed('/');
    }
  }


  static String paraHexa(int pNum) {
    var mNro = "";

    //print("pNum: [$pNum]");
    while (pNum >= 34) {
      mNro = mudaHexa(pNum % 34) + mNro;
      //print("mNro: $mNro");

      pNum = (pNum ~/ 34);
      //print("pNum: $pNum");
    }

    mNro = mudaHexa(pNum % 34) + mNro;
    //print("mNro: $mNro");

    return mNro;
  }


    static String chkIdent(String mNome) {
    var nAsc, nLen = mNome.length;
    var calc1CI = 0;
    var calc2CI = 0;

    //print("mNome: $mNome nLen: $nLen");

    for (int i = 0; i <= mNome.length - 1; i++) {
      var n = i + 1;
      nLen--;
      nAsc = const AsciiEncoder().convert(mNome[i]);
      nAsc = nAsc[0];
      int n1 = (nAsc * (pow(n, 3))); // 112 * (0+1)^3 = 112 * 1 = 112
      int n2 = (nAsc * (pow(nLen, 3)));
      calc1CI += n1;
      calc2CI += n2;
      //print("$n nAsc: [$nAsc] n1: [$n1] n2: [$n2] calc1: $calc1CI calc2: $calc2CI");
    }

    //print("calc1CI: [$calc1CI]\ncalc2CI: [$calc2CI]");
    String sCalc1CI = paraHexa(calc1CI);
    String sCalc2CI = paraHexa(calc2CI);
    //print("sCalc1CI: [$sCalc1CI]\nsCalc2CI: [$sCalc2CI]");

    sCalc1CI = sCalc1CI.length > 3
        ? sCalc1CI.substring(sCalc1CI.length - 4)
        : sCalc1CI;

    sCalc2CI = sCalc2CI.length > 2
        ? sCalc2CI.substring(sCalc2CI.length - 3)
        : sCalc2CI;
    return sCalc1CI + sCalc2CI;
  }


}
