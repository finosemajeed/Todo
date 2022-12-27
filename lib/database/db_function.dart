import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';

ValueNotifier<dynamic> todoNotifier = ValueNotifier([]);

// class Boxes {
//   static Box<TodoDataModel> getTodo() => Hive.box('Todo');
// }

// class HiveService {
//   static Box todoBox = Boxes.getTodo();
// }

class DbFunctions {
  DbFunctions._internal();
  static DbFunctions instance = DbFunctions._internal();

  factory DbFunctions() {
    return instance;
  }

  final _todoBox = Hive.box('Todo');

  void refreshItems() {
    final data = _todoBox.keys.map((key) {
      final value = _todoBox.get(key);
      return {
        'id': key,
        'title': value['title'],
        'description': value['description']
      };
    }).toList();
    todoNotifier.value.clear();
    todoNotifier.value.addAll(data.reversed.toList());
    todoNotifier.notifyListeners();
  }

  Future<void> createTodo(TodoDataModel todo) async {
    final key = await _todoBox.add(todo);
  
    log(key.toString());
    refreshItems();
  }

  TodoDataModel readTodo(int key) {
    final items = _todoBox.get(key);
    return items;
  }

  Future<void> updateTodo(int itemkey, TodoDataModel newTodo) async {
    await _todoBox.put(itemkey, newTodo);
    refreshItems();
  }

  Future<void> deleteTodo(int itemKey, BuildContext ctx) async {
    await _todoBox.delete(itemKey);
    refreshItems();
    ScaffoldMessenger.of(ctx)
        .showSnackBar(SnackBar(content: Text('Succesfully removed')));
  }
}
