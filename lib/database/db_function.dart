import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';

ValueNotifier<List<TodoDataModel>> todoNotifier = ValueNotifier([]);

class DbFunctions {
  DbFunctions._internal();
  static DbFunctions instance = DbFunctions._internal();

  factory DbFunctions() {
    return instance;
  }

  // final _todoBox = Hive.box('todo');

  void refreshItems() async {
    final _todoBox = await Hive.openBox<TodoDataModel>('todo');
    todoNotifier.value.clear();
    todoNotifier.value.addAll(_todoBox.values.toList());
    // _todoBox.clear();
    todoNotifier.notifyListeners();
  }

  Future<void> createTodo(TodoDataModel todo) async {
    final _todoBox = await Hive.openBox<TodoDataModel>('todo');
    final key = await _todoBox.add(todo);
    todo.id = key;
    todo.save();
    log(todo.id.toString());
    refreshItems();
  }

  Future<TodoDataModel?> readTodo(int key) async {
    final _todoBox = await Hive.openBox<TodoDataModel>('todo');
    final items = _todoBox.get(key);
    return items;
  }

  Future<void> updateTodo(int itemkey, TodoDataModel newTodo) async {
    final _todoBox = await Hive.openBox<TodoDataModel>('todo');
    await _todoBox.put(itemkey, newTodo);
    log(_todoBox.get(itemkey).toString());
    refreshItems();
  }

  Future<void> deleteTodo(int itemKey, BuildContext ctx) async {
    final _todoBox = await Hive.openBox<TodoDataModel>('todo');
    await _todoBox.delete(itemKey);
    refreshItems();
    ScaffoldMessenger.of(ctx)
        .showSnackBar(const SnackBar(content: Text('Succesfully removed')));
  }
}
