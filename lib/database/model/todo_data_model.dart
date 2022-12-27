import 'package:hive_flutter/hive_flutter.dart';
part 'todo_data_model.g.dart';

@HiveType(typeId: 1)
class TodoDataModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String title;
  @HiveField(2)
  String description;
  @HiveField(3)
  String? date;

  TodoDataModel({required this.title, required this.description}) {
    date = DateTime.now() as String;
  }
}
