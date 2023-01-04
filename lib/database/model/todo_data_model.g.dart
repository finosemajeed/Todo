// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo_data_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TodoDataModelAdapter extends TypeAdapter<TodoDataModel> {
  @override
  final int typeId = 1;

  @override
  TodoDataModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TodoDataModel(
      title: fields[1] as String?,
      description: (fields[4] as List?)?.cast<String>(),
      id: fields[0] as int?,
    )..date = fields[3] as dynamic;
  }

  @override
  void write(BinaryWriter writer, TodoDataModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(4)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TodoDataModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
