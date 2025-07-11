import 'package:hive/hive.dart';

part 'conta.g.dart';

@HiveType(typeId: 4)
class Conta {
  @HiveField(0)
  String? id;
  @HiveField(1)
  double? valor;
  @HiveField(2)
  DateTime? vencimento;
  @HiveField(3)
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
