// ignore_for_file: public_member_api_docs, sort_constructors_first
class Conta {
  String? id;
  double? valor;
  DateTime? vencimento;
  String? formaPagamento;

  Conta({
    this.id,
    this.valor,
    this.vencimento,
    this.formaPagamento,
  });
  
  factory Conta.fromJson(Map<String, dynamic> json) {
    return Conta(
      id: json['id'] as String?,
      valor: (json['valor'] as num?)?.toDouble(),
      vencimento: json['vencimento'] != null
          ? DateTime.parse(json['vencimento'])
          : null,
      formaPagamento: json['formaPagamento'] as String?,
    );
  }

    Map<String, dynamic> toJson() => {
    'id': id,
    'valor': valor,
    'vencimento': vencimento?.toIso8601String(),// Converte data para texto padronizado
    'formaPagamento': formaPagamento,
  };

}
