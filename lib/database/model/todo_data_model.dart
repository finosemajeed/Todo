import 'package:hive_flutter/hive_flutter.dart';
part 'todo_data_model.g.dart';

@HiveType(typeId: 1)
class TodoDataModel extends HiveObject {
  @HiveField(0)
  int? id;
  @HiveField(1)
  String? title;
  @HiveField(4)
  List<String>? description;
  @HiveField(3)
  var date;

  TodoDataModel({this.title, this.description, this.id}) {
    date = DateTime.now();
  }
}
