import 'package:speed_externo/commom/constantes/chaves.dart';
import 'package:speed_externo/commom/objetos/faturamento.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:hive/hive.dart';

part 'pedido.g.dart';

@HiveType(typeId: 2)
class Pedido {
  @HiveField(0)
  int? cod;
  @HiveField(1)
  int? codClie;
  @HiveField(2)
  List<Produto>? listProd;
  @HiveField(3)
  String? data;
  @HiveField(4)
  int? tipo;
  @HiveField(5)
  Faturamento? faturamento;
  @HiveField(6)
  String? status;
  @HiveField(7)
  double? total;
  @HiveField(8)
  double? subTotal;
  @HiveField(9)
  double? descontoReal;
  @HiveField(10)
  int? descontoPorcent;
  
  Pedido({
    this.cod,
    this.codClie,
    this.listProd,
    this.data,
    this.tipo,
    this.faturamento,
    this.status,
    this.total,
    this.subTotal,
    this.descontoReal,
    this.descontoPorcent,
  });

  Pedido copyWith({
    int? cod,
    int? codClie,
    List<Produto>? listProd,
    String? data,
    int? tipo,
    Faturamento? faturamento,
    String? status,
    double? total,
    double? subTotal,
    double? descontoReal,
    int? descontoPorcent,
  }) {
    return Pedido(
      cod: cod ?? this.cod,
      codClie: codClie ?? this.codClie,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      faturamento: faturamento ?? this.faturamento,
      listProd: listProd ?? this.listProd,
      status: status ?? this.status,
      total: total ?? this.total,
      subTotal: subTotal ?? this.subTotal,
      descontoPorcent: descontoPorcent ?? this.descontoPorcent,
      descontoReal: descontoReal ?? this.descontoReal
    );
  }
 factory Pedido.fromJson(Map<String, dynamic> json) {

    List listFromJson = json['listProd'];
    List<Produto> productList = listFromJson.isNotEmpty
        ? listFromJson.map((p) => Produto.fromJson(p)).toList()
        : [];

    return Pedido(
      cod: json[codPed],
      data: json[dataPed],
      tipo: json[tipoPed],
      codClie: json[codClientePed],
      faturamento: json[faturamentoPed] != null
          ? Faturamento.fromJson(json[faturamentoPed])
          : null,
      listProd: productList,
      status: json[statusPed],
      total: json[totalPed],
      subTotal: json[subTotalPed],
      descontoPorcent: json[descPorcentPed],
      descontoReal: json[descRealPed],
    );
  }

  Map<String, dynamic> toJson() => {
    codPed : cod,
    dataPed : data,
    tipoPed : tipo,
    codClientePed : codClie,
    statusPed : status,    
    faturamentoPed : faturamento?.toJson(),    
    listProdPed : listProd?.map((p) => p.toJson()).toList(),
    totalPed : total,
    subTotalPed : subTotal,
    descPorcentPed : descontoPorcent,
    descRealPed : descontoReal
  };

  // List<Pedido> obtemPedidos(String jsonString) {
  //   List<dynamic> listaGenerica = jsonDecode(jsonString);
  //   List<Pedido> pedidos = [];
  //   for (Map<String, dynamic> a in listaGenerica) {
  //     Pedido pedido = Pedido.fromJson(a);
  //     pedidos.add(pedido);
  //   }
  //   return pedidos;
  // }
  

}