// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'repository_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class RepositoryModelAdapter extends TypeAdapter<RepositoryModel> {
  @override
  final int typeId = 0;

  @override
  RepositoryModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RepositoryModel(
      hiveId: fields[0] as int,
      hiveName: fields[1] as String,
      hiveFullName: fields[2] as String,
      hiveHtmlUrl: fields[3] as String,
      hiveDescription: fields[4] as String?,
      hiveDefaultBranch: fields[5] as String,
      hiveStargazersCount: fields[6] as int,
      hiveForksCount: fields[7] as int,
      hiveOpenIssuesCount: fields[8] as int,
      hiveLanguage: fields[9] as String,
      hiveOwner: fields[10] as OwnerModel,
      hiveUpdatedAt: fields[11] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, RepositoryModel obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveName)
      ..writeByte(2)
      ..write(obj.hiveFullName)
      ..writeByte(3)
      ..write(obj.hiveHtmlUrl)
      ..writeByte(4)
      ..write(obj.hiveDescription)
      ..writeByte(5)
      ..write(obj.hiveDefaultBranch)
      ..writeByte(6)
      ..write(obj.hiveStargazersCount)
      ..writeByte(7)
      ..write(obj.hiveForksCount)
      ..writeByte(8)
      ..write(obj.hiveOpenIssuesCount)
      ..writeByte(9)
      ..write(obj.hiveLanguage)
      ..writeByte(10)
      ..write(obj.hiveOwner)
      ..writeByte(11)
      ..write(obj.hiveUpdatedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RepositoryModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class OwnerModelAdapter extends TypeAdapter<OwnerModel> {
  @override
  final int typeId = 1;

  @override
  OwnerModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OwnerModel(
      hiveId: fields[0] as int,
      hiveUsername: fields[1] as String,
      hiveAvatarUrl: fields[2] as String,
      hiveHtmlUrl: fields[3] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OwnerModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.hiveId)
      ..writeByte(1)
      ..write(obj.hiveUsername)
      ..writeByte(2)
      ..write(obj.hiveAvatarUrl)
      ..writeByte(3)
      ..write(obj.hiveHtmlUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OwnerModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
