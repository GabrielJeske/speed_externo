// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conta.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ContaAdapter extends TypeAdapter<Conta> {
  @override
  final int typeId = 4;

  @override
  Conta read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Conta(
      id: fields[0] as String?,
      valor: fields[1] as double?,
      vencimento: fields[2] as DateTime?,
      formaPagamento: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Conta obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.valor)
      ..writeByte(2)
      ..write(obj.vencimento)
      ..writeByte(3)
      ..write(obj.formaPagamento);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ContaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
