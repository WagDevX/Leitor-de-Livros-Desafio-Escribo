// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_book_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveBookModelAdapter extends TypeAdapter<HiveBookModel> {
  @override
  final int typeId = 0;

  @override
  HiveBookModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveBookModel()
      ..id = fields[0] as int?
      ..title = fields[1] as String?
      ..author = fields[2] as String?
      ..coverUrl = fields[3] as String?
      ..downloadUrl = fields[4] as String?
      ..favorite = fields[5] as double?;
  }

  @override
  void write(BinaryWriter writer, HiveBookModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.author)
      ..writeByte(3)
      ..write(obj.coverUrl)
      ..writeByte(4)
      ..write(obj.downloadUrl)
      ..writeByte(5)
      ..write(obj.favorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveBookModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
