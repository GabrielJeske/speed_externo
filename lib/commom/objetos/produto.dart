// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Produto {
  String? cod;
  String? nome;
  String? ncm;
  String? unidade;
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
    this.unidade,
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
      unidade: json['unidade'],
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
      'unidade': unidade,
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
  
  List<Produto> obtemProdutos(String jsonString){    
    List<dynamic> listaGenerica= jsonDecode(jsonString);
    List<Produto> produtos = [];
    for (Map<String, dynamic> a in listaGenerica) {   
      Produto produto = Produto.fromJson(a);
      produtos.add(produto);
    }
     return produtos; 
    }
    
   

  Produto copyWith({
    String? cod,
    String? nome,
    String? ncm,
    String? unidade,
    String? marca,
    String? apresentacao,
    String? grupo1,
    String? grupo2,
    String? grupo3,
    String? cst,
    String? custo,
    String? fabrica,
    String? venda,
    String? estoqueatual,
    String? estoqueparcial,
    String? quantidade,
    String? unitario,
    String? total,
  }) {
    return Produto(
      cod: cod ?? this.cod,
      nome: nome ?? this.nome,
      ncm: ncm ?? this.ncm,
      unidade: unidade ?? this.unidade,
      marca: marca ?? this.marca,
      apresentacao: apresentacao ?? this.apresentacao,
      grupo1: grupo1 ?? this.grupo1,
      grupo2: grupo2 ?? this.grupo2,
      grupo3: grupo3 ?? this.grupo3,
      cst: cst ?? this.cst,
      custo: custo ?? this.custo,
      fabrica: fabrica ?? this.fabrica,
      venda: venda ?? this.venda,
      estoqueatual: estoqueatual ?? this.estoqueatual,
      estoqueparcial: estoqueparcial ?? this.estoqueparcial,
      quantidade: quantidade ?? this.quantidade,
      unitario: unitario ?? this.unitario,
      total: total ?? this.total,
    );
  }
}
