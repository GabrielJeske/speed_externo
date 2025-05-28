import 'dart:convert';


class Pedido {
  String? cod;
  String? codClie;
  List<Map<String, dynamic>> listProd;
  String? data;
  String? tipo;
  Map<String, dynamic>? fatur;
  
  Pedido({
    this.cod,
    this.codClie,
    required this.listProd,
    this.data,
    this.tipo,
    this.fatur,
  });

  factory Pedido.fromJson(Map json){
    return Pedido(
      cod: json['cod'],
      codClie: json['codClie'],
      listProd: json['listProd'],
      data: json['data'],
      tipo: json['tipo'],
      fatur:  json['fatur'],      
    );
  }

  Map toJson(){
    return{
      'cod': cod,
      'codClie': codClie,
      'listProd': listProd,
      'data': data,
      'tipo': tipo,
      'fatur':  fatur,      
    };
  }
  
  List<Map<String, dynamic>> deserializaJson(String jsonString){
    List<dynamic> conteudoJson = jsonDecode(jsonString);
    List<Map<String, dynamic>> listJson = List<Map<String, dynamic>>.from(conteudoJson);
    return listJson;
  }

  

}