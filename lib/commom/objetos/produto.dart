import 'package:hive/hive.dart';
import 'package:speed_externo/commom/constantes/chaves.dart';

part 'produto.g.dart';

@HiveType(typeId: 1)
class Produto {
  @HiveField(0)
  int? nProd;
  @HiveField(1)
  int? cod;
  @HiveField(2)
  String? nome;
  @HiveField(3)
  int? ncm;
  @HiveField(4)
  String? unidade;
  @HiveField(5)
  String? marca;
  @HiveField(6)
  String? apresentacao;
  @HiveField(7)
  int? grupo1;
  @HiveField(8)
  int? grupo2;
  @HiveField(9)
  int? grupo3;
  @HiveField(10)
  int? cst;
  @HiveField(11)
  double? custo;
  @HiveField(12)
  double? fabrica;
  @HiveField(13)
  double? venda;
  @HiveField(14)
  int? estoqueatual;
  @HiveField(15)
  int? estoqueparcial;
  @HiveField(16)
  int? quantidade;
  @HiveField(17)
  double? unitario;
  @HiveField(18)
  double? total;
  
   Produto({
    this.nProd,
    this.cod,
    this.nome,
    this.ncm,
    this.unidade,
    this.marca,
    this.apresentacao,
    this.grupo1,
    this.grupo2,
    this.grupo3,
    this.cst,
    this.custo,
    this.fabrica,
    this.venda,
    this.estoqueatual,
    this.estoqueparcial,
    this.quantidade,
    this.unitario,
    this.total,
  });
 
  factory Produto.fromJson(Map json){
    return Produto(
      nProd: int.tryParse(json[numProd].toString()), // Converte para int
      cod: int.tryParse(json[codProd].toString()),   // Converte para int
      nome: json[nomeProd] as String?, // Se você sabe que sempre será String
      ncm: int.tryParse(json[ncmProd].toString()),   // Converte para int
      unidade: json[unidadeProd] as String?,
      marca: json[marcaProd] as String?,
      apresentacao: json[apresentProd] as String?,
      grupo1: int.tryParse(json[grupo1Prod].toString()),
      grupo2: int.tryParse(json[grupo2Prod].toString()),
      grupo3: int.tryParse(json[grupo3Prod].toString()),
      cst: int.tryParse(json[cstProd].toString()),
      // Para doubles, cuidado com vírgulas
      fabrica: double.tryParse(json[fabricaProd].toString().replaceAll(',', '.')),
      custo: double.tryParse(json[custoProd].toString().replaceAll(',', '.')),
      venda: double.tryParse(json[vendaProd].toString().replaceAll(',', '.')),
      estoqueatual: int.tryParse(json[estqatualProd].toString()),
      estoqueparcial: int.tryParse(json[estqparcialProd].toString()),
      quantidade: int.tryParse(json[qtdProd].toString()),
      unitario: double.tryParse(json[unitarioProd].toString().replaceAll(',', '.')),
      total: double.tryParse(json[totalProd].toString().replaceAll(',', '.')),
    );
  }

 Map<String, dynamic> toJson() {
    return{
      numProd : nProd,
      codProd: cod,
      nomeProd: nome,
      ncmProd: ncm,
      unidadeProd: unidade,
      marcaProd: marca,
      apresentProd: apresentacao,  
      grupo1Prod: grupo1,  
      grupo2Prod: grupo2,  
      grupo3Prod: grupo3,  
      cstProd: cst,
      fabricaProd:fabrica,
      custoProd: custo,
      vendaProd: venda,
      estqatualProd:estoqueatual,
      estqparcialProd:estoqueparcial,
      qtdProd:quantidade,
      unitarioProd:unitario,
      totalProd:total, 
    };
  }
    
  Produto copyWith({
    int? nProd,
    int? cod,
    String? nome,
    int? ncm,
    String? unidade,
    String? marca,
    String? apresentacao,
    int? grupo1,
    int? grupo2,
    int? grupo3,
    int? cst,
    double? custo,
    double? fabrica,
    double? venda,
    int? estoqueatual,
    int? estoqueparcial,
    int? quantidade,
    double? unitario,
    double? total,
  }) {
    return Produto(
      nProd: nProd ?? this.nProd,
      cod: cod ,
      nome: nome ?? this.nome,
      ncm: ncm ?? this.ncm,
      unidade: unidade ?? this.unidade,
      marca: marca ?? this.marca,
      apresentacao: apresentacao ?? this.apresentacao,
      grupo1: grupo1 ?? this.grupo1,
      grupo2: grupo2 ?? this.grupo2,
      grupo3: grupo3 ?? this.grupo3,
      cst: cst ?? this.cst,
      custo: custo ?? this.custo,
      fabrica: fabrica ?? this.fabrica,
      venda: venda ?? this.venda,
      estoqueatual: estoqueatual ?? this.estoqueatual,
      estoqueparcial: estoqueparcial ?? this.estoqueparcial,
      quantidade: quantidade ?? this.quantidade,
      unitario: unitario ?? this.unitario,
      total: total ?? this.total,
    );
  }

    // List<Produto> obtemProdutos(String jsonString){    
    // List<dynamic> listaGenerica= jsonDecode(jsonString);
    // List<Produto> produtos = [];
    // for (Map<String, dynamic> a in listaGenerica) {   
    //   Produto produto = Produto.fromJson(a);
    //   produtos.add(produto);
    // }
    //  return produtos; 
    // }

}
