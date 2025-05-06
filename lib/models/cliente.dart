class PessoaFisica {
  String nome;
  String cpf;
  DateTime dataNascimento;
  String endereco;
  String telefone;
  String cep;
  String? ie;
  String contribuinte;
  String profissao;

  PessoaFisica({
    required this.nome,
    required this.cpf,
    required this.dataNascimento,
    required this.endereco,
    required this.telefone,
    required this.cep,
    this.ie,
    required this.contribuinte,
    required this.profissao,
  });
}

class PessoaJuridica {
  String razaoSocial;
  String cnpj;
  String nomeFantasia;
  String endereco;
  String telefone;
  String cep;
  String? ie;
  String contribuinte;
  String ramo;

  PessoaJuridica({
    required this.razaoSocial,
    required this.cnpj,
    required this.nomeFantasia,
    required this.endereco,
    required this.telefone,
    required this.cep,
    this.ie,
    required this.contribuinte,
    required this.ramo,
  });
}
