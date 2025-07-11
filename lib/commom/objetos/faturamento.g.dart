// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'faturamento.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FaturamentoAdapter extends TypeAdapter<Faturamento> {
  @override
  final int typeId = 3;

  @override
  Faturamento read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Faturamento(
      parcelas: fields[0] as int?,
      contas: (fields[2] as List).cast<Conta>(),
    );
  }

  @override
  void write(BinaryWriter writer, Faturamento obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.parcelas)
      ..writeByte(2)
      ..write(obj.contas);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FaturamentoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
