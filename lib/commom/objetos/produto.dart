// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Produto {
  String? cod;
  String? nome;
  String? ncm;
  String? un;
  String? marca;
  String? apresentacao;
  String? grupo1;
  String? grupo2;
  String? grupo3;
  String? cst;
  String? custo;
  String? fabrica;
  String? venda;
  String? estoqueatual;
  String? estoqueparcial;
  String? quantidade;
  String? unitario;
  String? total;
  
  Produto({
    this.cod,
    this.nome,
    this.ncm,
    this.un,
    this.marca,
    this.apresentacao,
    this.grupo1,
    this.grupo2,
    this.grupo3,
    this.cst,
    this.custo,
    this.fabrica,
    this.venda,
    this.estoqueatual,
    this.estoqueparcial,
    this.quantidade,
    this.unitario,
    this.total,
  });

  factory Produto.fromJson(Map json){
    return Produto(
      cod: json['cod'],
      nome: json['nome'],
      ncm: json['ncm'],
      un: json['un'],
      marca: json['marca'],
      apresentacao: json['apresentacao'],
      grupo1: json['grupo1'],
      grupo2: json['grupo2'],
      grupo3: json['grupo3'],
      cst: json['cst'],
      fabrica: json['fabrica'],
      custo: json['custo'],    
      venda: json['venda'],
      estoqueatual: json['estoqueatual'],
      estoqueparcial: json['estoqueparcial'],          
      quantidade: json['cusquantidadeto'],          
      unitario: json['custunitarioo'],          
      total: json['total'],          

    );
  }

  Map toJson(){
    return{
      'cod': cod,
      'nome': nome,
      'ncm': ncm,
      'un': un,
      'marca': marca,
      'apresentacao': apresentacao,  
      'grupo1': grupo1,  
      'grupo2': grupo2,  
      'grupo3': grupo3,  
      'cst': cst,
      'fabrica':fabrica,
      'custo': custo,
      'venda': venda,   
      'fabrestoqueatualica':estoqueatual,
      'estoqueparcial':estoqueparcial,
      'quantidade':quantidade,
      'unitario':unitario,
      'total':total, 
    };
  }
  
  List<Map<String, dynamic>> deserializaJson(String jsonString){
    List<dynamic> conteudoJson = jsonDecode(jsonString);
    List<Map<String, dynamic>> listJson = List<Map<String, dynamic>>.from(conteudoJson);
    return listJson;
  }
}
