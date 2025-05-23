// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Produto {
  String? cod;
  String? nome;
  String? ncm;
  String? un;
  String? marca;
  String? cst;
  String? custo;
  String? venda;
  
  Produto({
    this.cod,
    this.nome,
    this.ncm,
    this.un,
    this.marca,
    this.cst,
    this.custo,
    this.venda,
  });

  factory Produto.fromJson(Map json){
    return Produto(
      cod: json['cod'],
      nome: json['nome'],
      ncm: json['ncm'],
      un: json['un'],
      marca: json['marca'],
      cst: json['cst'],
      custo: json['venda'],
      venda: json['venda'],          
    );
  }

  Map toJson(){
    return{
      'cod': cod,
      'nome': nome,
      'ncm': ncm,
      'un': un,
      'marca': marca,
      'cst': cst,
      'custo': custo,
      'venda': venda,    
    };
  }
  
  List<Map<String, dynamic>> deserializaJson(String jsonString){
    List<dynamic> conteudoJson = jsonDecode(jsonString);
    List<Map<String, dynamic>> listJson = List<Map<String, dynamic>>.from(conteudoJson);
    return listJson;
  }
}
