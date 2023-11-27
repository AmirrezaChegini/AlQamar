// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ArticleAdapter extends TypeAdapter<Article> {
  @override
  final int typeId = 1;

  @override
  Article read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Article(
      fields[0] as int,
      fields[1] as String?,
      fields[2] as String?,
      fields[3] as String?,
      fields[4] as String?,
      fields[5] as String?,
      fields[6] as String?,
      fields[7] as dynamic,
      fields[8] as dynamic,
      fields[9] as dynamic,
      fields[10] as dynamic,
    );
  }

  @override
  void write(BinaryWriter writer, Article obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj._id)
      ..writeByte(1)
      ..write(obj._title)
      ..writeByte(2)
      ..write(obj._content)
      ..writeByte(3)
      ..write(obj._writer)
      ..writeByte(4)
      ..write(obj._type)
      ..writeByte(5)
      ..write(obj._createAt)
      ..writeByte(6)
      ..write(obj._youtube)
      ..writeByte(7)
      ..write(obj._images)
      ..writeByte(8)
      ..write(obj._videos)
      ..writeByte(9)
      ..write(obj._audios)
      ..writeByte(10)
      ..write(obj._pdfs);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ArticleAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
