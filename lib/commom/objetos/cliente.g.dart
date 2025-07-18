// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cliente.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ClienteAdapter extends TypeAdapter<Cliente> {
  @override
  final int typeId = 0;

  @override
  Cliente read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Cliente(
      id: fields[0] as int?,
      razaosocial: fields[1] as String?,
      cnpj: fields[2] as String?,
      fantasia: fields[3] as String?,
      ie: fields[4] as String?,
      endereco: fields[5] as String?,
      cep: fields[6] as String?,
      email: fields[7] as String?,
      contato: fields[8] as String?,
      numeroContato: fields[9] as String?,
      contribuinte: fields[10] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, Cliente obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.razaosocial)
      ..writeByte(2)
      ..write(obj.cnpj)
      ..writeByte(3)
      ..write(obj.fantasia)
      ..writeByte(4)
      ..write(obj.ie)
      ..writeByte(5)
      ..write(obj.endereco)
      ..writeByte(6)
      ..write(obj.cep)
      ..writeByte(7)
      ..write(obj.email)
      ..writeByte(8)
      ..write(obj.contato)
      ..writeByte(9)
      ..write(obj.numeroContato)
      ..writeByte(10)
      ..write(obj.contribuinte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClienteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
