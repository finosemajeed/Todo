import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';

class UpdateTask extends StatelessWidget {
  UpdateTask({super.key, required this.data});
  final TodoDataModel data;

  TextEditingController todoController = TextEditingController();
  final ValueNotifier<List<String>> updateTodoListNotifier = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    DbFunctions().refreshItems();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          shrinkWrap: true,
          primary: true,
          physics: BouncingScrollPhysics(),
          // crossAxisAlignment: CrossAxisAlignment.start,
          // mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 5),
            Text(
              data.title.toString(),
              style: TextStyle(
                color: kWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            TextFormField(
              controller: todoController,
              decoration: InputDecoration(
                  label: Text('New Todo'),
                  suffix: IconButton(
                    onPressed: () {
                      if (todoController.text.isNotEmpty) {
                        updateTodoListNotifier.value.add(todoController.text);
                        updateTodoListNotifier.notifyListeners();
                      }

                      todoController.text = "";
                      // log(todoList.toString());
                      newTodo(data.id);
                      log(data.id.toString());
                    },
                    icon: Icon(
                      Icons.check,
                      color: kOrange,
                    ),
                  )),
            ),
            ValueListenableBuilder(
                valueListenable: updateTodoListNotifier,
                builder: (context, ee, _) {
                  return Expanded(
                    child: ListView.builder(
                      physics: ClampingScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: data.description?.length ?? 0,
                      itemBuilder: (context, index) {
                        return ListTile(
                          leading: Checkbox(
                              value: false, onChanged: ((value) => {})),
                          title: Text(
                            // ee.elementAt(data.id!).description![index]
                            data.description![index],
                            style: TextStyle(color: kWhiteText),
                          ),
                        );
                      },
                    ),
                  );
                }),
            Divider(),
            Text('completed'),
            ListView.builder(
              shrinkWrap: true,
              physics: ClampingScrollPhysics(),
              itemCount: data.description?.length ?? 0,
              itemBuilder: (context, index) {
                return data.description!.isNotEmpty
                    ? ListTile(
                        leading: Icon(
                          Icons.check,
                          color: kOrange,
                        ),
                        title: Text(
                          data.description![index],
                          style: TextStyle(
                              color: kWhiteText,
                              decoration: TextDecoration.lineThrough),
                        ),
                      )
                    : Spacer();
              },
            ),
          ],
        ),
      ),
    );
  }

  void newTodo(int? itemKey) {
    final description = todoController.text.trim();
    if (itemKey != null) {
      // final existingItem =
      //     todoNotifier.value.firstWhere((element) => element.id == itemKey);
      // todoController.text = existingItem.description! as String;

      final TodoDataModel newTodo = TodoDataModel(
          description: updateTodoListNotifier.value,
          title: data.title,
          id: data.id);
      DbFunctions().updateTodo(itemKey, newTodo);
    }
  }
}
