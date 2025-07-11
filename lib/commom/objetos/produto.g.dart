// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'produto.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProdutoAdapter extends TypeAdapter<Produto> {
  @override
  final int typeId = 1;

  @override
  Produto read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Produto(
      nProd: fields[0] as String?,
      cod: fields[1] as String?,
      nome: fields[2] as String?,
      ncm: fields[3] as String?,
      unidade: fields[4] as String?,
      marca: fields[5] as String?,
      apresentacao: fields[6] as String?,
      grupo1: fields[7] as String?,
      grupo2: fields[8] as String?,
      grupo3: fields[9] as String?,
      cst: fields[10] as String?,
      custo: fields[11] as String?,
      fabrica: fields[12] as String?,
      venda: fields[13] as String?,
      estoqueatual: fields[14] as String?,
      estoqueparcial: fields[15] as String?,
      quantidade: fields[16] as String?,
      unitario: fields[17] as String?,
      total: fields[18] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Produto obj) {
    writer
      ..writeByte(19)
      ..writeByte(0)
      ..write(obj.nProd)
      ..writeByte(1)
      ..write(obj.cod)
      ..writeByte(2)
      ..write(obj.nome)
      ..writeByte(3)
      ..write(obj.ncm)
      ..writeByte(4)
      ..write(obj.unidade)
      ..writeByte(5)
      ..write(obj.marca)
      ..writeByte(6)
      ..write(obj.apresentacao)
      ..writeByte(7)
      ..write(obj.grupo1)
      ..writeByte(8)
      ..write(obj.grupo2)
      ..writeByte(9)
      ..write(obj.grupo3)
      ..writeByte(10)
      ..write(obj.cst)
      ..writeByte(11)
      ..write(obj.custo)
      ..writeByte(12)
      ..write(obj.fabrica)
      ..writeByte(13)
      ..write(obj.venda)
      ..writeByte(14)
      ..write(obj.estoqueatual)
      ..writeByte(15)
      ..write(obj.estoqueparcial)
      ..writeByte(16)
      ..write(obj.quantidade)
      ..writeByte(17)
      ..write(obj.unitario)
      ..writeByte(18)
      ..write(obj.total);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProdutoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
