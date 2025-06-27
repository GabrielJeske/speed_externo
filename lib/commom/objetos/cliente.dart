
class Cliente {
  String? id;
  String? razaosocial;
  String? cnpj;
  String? fantasia;  
  String? ie;
  String? endereco;
  String? cep;
  String? email;
  String? contato;
  String? numeroContato;
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
