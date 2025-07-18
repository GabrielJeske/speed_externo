import 'package:hive/hive.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';

part 'conta.g.dart';

@HiveType(typeId: 4)
class Conta {
  @HiveField(0)
  int? id;
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
      id: json[idCont],
      valor: json[valorCont],
      vencimento: json[vencimentoCont],
      formaPagamento: json[formaPgtoCont],
    );
  }

  Map<String, dynamic> toJson() => {
    idCont: id,
    valorCont: valor,
    vencimentoCont: vencimento,
    formaPgtoCont: formaPagamento,
  };

}
