// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PedidoAdapter extends TypeAdapter<Pedido> {
  @override
  final int typeId = 2;

  @override
  Pedido read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pedido(
      cod: fields[0] as int?,
      codClie: fields[1] as int?,
      listProd: (fields[2] as List?)?.cast<Produto>(),
      data: fields[3] as String?,
      tipo: fields[4] as int?,
      faturamento: fields[5] as Faturamento?,
      status: fields[6] as String?,
      total: fields[7] as double?,
      subTotal: fields[8] as double?,
      descontoReal: fields[9] as double?,
      descontoPorcent: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Pedido obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.cod)
      ..writeByte(1)
      ..write(obj.codClie)
      ..writeByte(2)
      ..write(obj.listProd)
      ..writeByte(3)
      ..write(obj.data)
      ..writeByte(4)
      ..write(obj.tipo)
      ..writeByte(5)
      ..write(obj.faturamento)
      ..writeByte(6)
      ..write(obj.status)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.subTotal)
      ..writeByte(9)
      ..write(obj.descontoReal)
      ..writeByte(10)
      ..write(obj.descontoPorcent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PedidoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
