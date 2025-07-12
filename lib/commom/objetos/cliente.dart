
import 'package:hive/hive.dart';

part 'cliente.g.dart';

@HiveType(typeId: 0)
class Cliente {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? razaosocial;
  @HiveField(2)
  String? cnpj;
  @HiveField(3)
  String? fantasia;  
  @HiveField(4)
  String? ie;
  @HiveField(5)
  String? endereco;
  @HiveField(6)
  String? cep;
  @HiveField(7)
  String? email;
  @HiveField(8)
  String? contato;
  @HiveField(9)
  String? numeroContato;
  @HiveField(10)
  String? contribuinte;
  Cliente({
     this.id,
     this.razaosocial,
     this.cnpj,
    this.fantasia,
    this.ie,
    this.endereco,    
    this.cep,
    this.email,
    this.contato,
    this.numeroContato,
    this.contribuinte,
  });

   factory Cliente.fromJson(Map<String, dynamic> json){
    return Cliente(
      id: json['id'].toString(),
      razaosocial: json['razaosocial'].toString(),
      fantasia: json['fantasia'].toString(),
      cnpj: json['cnpj'].toString(),
      contribuinte: json['contribuinte'].toString(),
      ie: json['ie'].toString(),
      endereco: json['endereco'].toString(),
      cep: json['cep'].toString(),
      email: json['email'].toString(),
      contato: json['contato'].toString(),
      numeroContato: json['numeroContato'].toString(),
    );
  }

 

  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'razaosocial': razaosocial,
      'fantasia': fantasia,
      'cnpj': cnpj,
      'contribuinte': contribuinte,
      'ie': ie,
      'endereco': endereco,
      'cep': cep,
      'email': email,
      'contato': contato,
      'numeroContato': numeroContato,
    };
  }

  Cliente copyWith({
    String? id,
    String? nome,
    String? cpf,
    String? razaosocial,
    String? fantasia,
    String? cnpj,
    String? ie,
    String? endereco,
    String? numero,
    String? bairro,
    String? cep,
    String? email,
    String? contato,
    String? numeroContato,
    String? contribuinte,
    String? logadouro,
  }) {
    return Cliente(
      id: id ?? this.id,
      razaosocial: razaosocial ?? this.razaosocial,
      fantasia: fantasia ?? this.fantasia,
      cnpj: cnpj ?? this.cnpj,
      ie: ie ?? this.ie,
      endereco: endereco ?? this.endereco,
      cep: cep ?? this.cep,
      email: email ?? this.email,
      contato: contato ?? this.contato,
      numeroContato: numeroContato ?? this.numeroContato,
      contribuinte: contribuinte ?? this.contribuinte,
    );
  }


}
