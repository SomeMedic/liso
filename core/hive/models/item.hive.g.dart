// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'item.hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveLisoItemAdapter extends TypeAdapter<HiveLisoItem> {
  @override
  final int typeId = 0;

  @override
  HiveLisoItem read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveLisoItem(
      identifier: fields[0] as String,
      groupId: fields[1] as String,
      category: fields[2] as String,
      title: fields[3] as String,
      iconUrl: fields[4] as String,
      fields: (fields[5] as List).cast<HiveLisoField>(),
      favorite: fields[6] as bool,
      protected: fields[7] as bool,
      trashed: fields[8] as bool,
      deleted: fields[9] as bool,
      reserved: fields[10] as bool,
      hidden: fields[11] as bool,
      tags: (fields[12] as List).cast<String>(),
      sharedVaultIds: (fields[13] as List).cast<String>(),
      attachments: (fields[14] as List).cast<String>(),
      metadata: fields[15] as HiveMetadata,
      uris: (fields[18] as List?)?.cast<String>(),
      appIds: (fields[17] as List?)?.cast<String>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveLisoItem obj) {
    writer
      ..writeByte(18)
      ..writeByte(0)
      ..write(obj.identifier)
      ..writeByte(1)
      ..write(obj.groupId)
      ..writeByte(2)
      ..write(obj.category)
      ..writeByte(3)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.iconUrl)
      ..writeByte(5)
      ..write(obj.fields)
      ..writeByte(6)
      ..write(obj.favorite)
      ..writeByte(7)
      ..write(obj.protected)
      ..writeByte(8)
      ..write(obj.trashed)
      ..writeByte(9)
      ..write(obj.deleted)
      ..writeByte(10)
      ..write(obj.reserved)
      ..writeByte(11)
      ..write(obj.hidden)
      ..writeByte(12)
      ..write(obj.tags)
      ..writeByte(13)
      ..write(obj.sharedVaultIds)
      ..writeByte(14)
      ..write(obj.attachments)
      ..writeByte(15)
      ..write(obj.metadata)
      ..writeByte(17)
      ..write(obj.appIds)
      ..writeByte(18)
      ..write(obj.uris);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveLisoItemAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
