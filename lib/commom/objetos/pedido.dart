import 'dart:convert';
import 'package:speed_externo/commom/objetos/faturamento.dart';
import 'package:speed_externo/commom/objetos/produto.dart';
import 'package:hive/hive.dart';

part 'pedido.g.dart';

@HiveType(typeId: 2)
class Pedido {
  @HiveField(0)
  String? cod;
  @HiveField(1)
  String? codClie;
  @HiveField(2)
  List<Produto>? listProd;
  @HiveField(3)
  String? data;
  @HiveField(4)
  String? tipo;
  @HiveField(5)
  Faturamento? faturamento;
  @HiveField(6)
  String? status;
  
  Pedido({
    this.cod,
    this.codClie,
    required this.listProd,
    this.data,
    this.tipo,
    this.faturamento,
    this.status,
  });

  Pedido copyWith({
    String? cod,
    String? codClie,
    List<Produto>? listProd,
    String? data,
    String? tipo,
    Faturamento? faturamento,
    String? status,
  }) {
    return Pedido(
      cod: cod ?? this.cod,
      codClie: codClie ?? this.codClie,
      data: data ?? this.data,
      tipo: tipo ?? this.tipo,
      faturamento: faturamento ?? this.faturamento,
      listProd: listProd ?? this.listProd,
      status: status ?? this.status,
    );
  }
 factory Pedido.fromJson(Map<String, dynamic> json) {

    // 1. Pega a lista "crua" (List<dynamic>) do JSON.
    var listFromJson = json['listProd'] as List?;

    // 2. Transforma a lista crua em uma List<Produto>.
    // Se a lista do json for nula, cria uma lista vazia.
    List<Produto> productList = listFromJson != null
        ? listFromJson.map((p) => Produto.fromJson(p)).toList()
        : [];

    return Pedido(
      cod: json['cod'],
      data: json['data'],
      tipo: json['tipo'],
      codClie: json['codClie'],
      faturamento: json['faturamento'] != null
          ? Faturamento.fromJson(json['faturamento'])
          : null,
      
      // 3. Atribui a lista devidamente convertida.
      listProd: productList,
      status: json['status'],
    );
  }
 Map<String, dynamic> toJson() => {
    'cod': cod,
    'data': data,
    'tipo': tipo,
    'codClie': codClie,
    'status': status,
    // Usa o '?' para o caso de faturamento ser nulo
    'faturamento': faturamento?.toJson(),
    // Usa o '?' para o caso de a lista ser nula (conforme discutimos)
    'listProd': listProd?.map((p) => p.toJson()).toList(),
  };

  List<Pedido> obtemPedidos(String jsonString) {
    List<dynamic> listaGenerica = jsonDecode(jsonString);
    List<Pedido> pedidos = [];
    for (Map<String, dynamic> a in listaGenerica) {
      Pedido pedido = Pedido.fromJson(a);
      pedidos.add(pedido);
    }
    return pedidos;
  }
  

}