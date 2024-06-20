// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ListHiveModelAdapter extends TypeAdapter<ListHiveModel> {
  @override
  final int typeId = 0;

  @override
  ListHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ListHiveModel(
      id: fields[0] as String,
      title: fields[1] as String,
      isPinned: fields[2] as bool,
      label: fields[3] as String,
      date: fields[4] as String,
      time: fields[5] as String,
      todos: (fields[6] as List).cast<TodoHiveModel>(),
    );
  }

  @override
  void write(BinaryWriter writer, ListHiveModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.isPinned)
      ..writeByte(3)
      ..write(obj.label)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.time)
      ..writeByte(6)
      ..write(obj.todos);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ListHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
