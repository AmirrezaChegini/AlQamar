// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'salavat.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalavatAdapter extends TypeAdapter<Salavat> {
  @override
  final int typeId = 0;

  @override
  Salavat read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Salavat(
      fields[0] as int,
      fields[1] == null ? 0 : fields[1] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Salavat obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._numbers);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalavatAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
