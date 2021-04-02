// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_text_entry_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FavoriteTextEntryEntityAdapter
    extends TypeAdapter<FavoriteTextEntryEntity> {
  @override
  final int typeId = 1;

  @override
  FavoriteTextEntryEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FavoriteTextEntryEntity(
      textToBeTranslated: fields[0] as String,
      translatedText: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FavoriteTextEntryEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.textToBeTranslated)
      ..writeByte(1)
      ..write(obj.translatedText);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavoriteTextEntryEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
