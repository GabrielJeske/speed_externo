// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:speed_externo/commom/objetos/conta.dart';

class Faturamento {
  int? parcelas;
  List<Conta> contas;

  Faturamento({
    this.parcelas,
    required this.contas,
  });

  Faturamento copyWith({
    int? parcelas,
    List<Conta>? contas,
  }) {
    return Faturamento(
      parcelas: parcelas ?? this.parcelas,
      contas: contas ?? this.contas,
    );
  }
  factory Faturamento.fromJson(Map<String, dynamic> json) {
    var listFromJson = json['contas'] as List?;
    List<Conta> contasList = listFromJson != null
        ? listFromJson.map((c) => Conta.fromJson(c)).toList()
        : [];

    return Faturamento(
      parcelas: json['parcelas'],
      contas: contasList,
    );
  }
  
   Map<String, dynamic> toJson() => {
    'parcelas': parcelas,
    'contas': contas.map((c) => c.toJson()).toList(),
  };
  
}
