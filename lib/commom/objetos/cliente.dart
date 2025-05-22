// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Cliente {
  String? id;
  String? nome;
  String? cpf;
  String? razaosocial;
  String? fantasia;
  String? cnpj;
  String? ie;
  String? endereco;
  String? numero;
  String? bairro;
  String? cep;
  String? email;
  String? contato;
  String? numeroContato;
  String? contribuinte;
  String? logadouro;
  Cliente({
    this.id,
    this.nome,
    this.cpf,
    this.razaosocial,
    this.fantasia,
    this.cnpj,
    this.ie,
    this.endereco,
    this.numero,
    this.bairro,
    this.cep,
    this.email,
    this.contato,
    this.numeroContato,
    this.contribuinte,
    this.logadouro,
  });

  factory Cliente.fromJson(Map json){
    return Cliente(
      id: json['id'],
      nome: json['nome'],
      cpf: json['cpf'],
      razaosocial: json['razaosocial'],
      fantasia: json['fantasia'],
      cnpj: json['cnpj'],
      contribuinte: json['contribuinte'],
      ie: json['ie'],      
      logadouro: json['logadouro'],
      endereco: json['endereco'],
      numero: json['numero'],
      bairro: json['bairro'],
      cep: json['cep'],
      email: json['email'],
      contato: json['contato'],
      numeroContato: json['numeroContato'],      
    );
  }

  Map toJson(){
    return{
      'id': id,
      'nome': nome,
      'cpf': cpf,
      'razaosocial': razaosocial,
      'fantasia': fantasia,
      'cnpj': cnpj,
      'contribuinte': contribuinte,
      'ie': ie,
      'logadouro': logadouro,
      'endereco': endereco,
      'numero': numero,
      'bairro': bairro,
      'cep': cep,
      'email': email,
      'contato': contato,
      'numeroContato': numeroContato,
    };
  }
  
  List<Map<String, dynamic>> deserializaJson(String jsonString){
    List<dynamic> conteudoJson = jsonDecode(jsonString);
    List<Map<String, dynamic>> listJson = List<Map<String, dynamic>>.from(conteudoJson);
    return listJson;
  }
}
