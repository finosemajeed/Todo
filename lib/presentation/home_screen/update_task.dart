import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';

class UpdateTask extends StatelessWidget {
  UpdateTask({super.key, required this.data});
  final TodoDataModel data;

  TextEditingController todoController = TextEditingController();

  late List<String> updateTodoList = [...?data.description];
  late List<String> removeTodoList = [...?data.description];

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
          physics: const BouncingScrollPhysics(),
          children: [
            const SizedBox(height: 5),
            Text(
              data.title.toString(),
              style: const TextStyle(
                color: kWhite,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 5),
            SizedBox(
              height: 70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  style: const TextStyle(color: kWhite),
                  controller: todoController,
                  decoration: InputDecoration(
                    suffix: IconButton(
                        onPressed: () {
                          if (todoController.text.isNotEmpty) {
                            updateTodoList.add(todoController.text);
                            newTodo(data.id);
                          }

                          todoController.text = "";
                        },
                        icon: const Icon(
                          Icons.check,
                          color: kOrange,
                        )),
                    border: const OutlineInputBorder(),
                    labelText: "Add Todo\'s",
                    labelStyle: const TextStyle(
                      color: kOrange,
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return "Please enter your task description";
                    }
                    return null;
                  },
                ),
              ),
            ),
            // ValueListenableBuilder(
            //     valueListenable: todoNotifier,
            //     builder: (context, ee, _) {
            //       return ListView.builder(
            //         physics: ClampingScrollPhysics(),
            //         shrinkWrap: true,
            //         itemCount: data.description?.length ?? 0,
            //         itemBuilder: (context, index) {
            //           return ListTile(
            //             leading:
            //                 Checkbox(value: false, onChanged: ((value) => {})),
            //             title: Text(
            //               // ee.elementAt(data.id!).description![index],

            //               data.description![index],
            //               style: TextStyle(color: kWhiteText),
            //             ),
            //           );
            //         },
            //       );
            //     }),
            const Divider(),
            const Text(
              'Todo\'s',
              style: TextStyle(
                color: kWhiteText,
                fontSize: 18,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const ClampingScrollPhysics(),
              itemCount: data.description?.length ?? 0,
              itemBuilder: (context, index) {
                final String item = data.description![index];
                return data.description!.isNotEmpty
                    ? Dismissible(
                        key: Key(item),
                        onDismissed: (direction) {
                          removetodo(index, data.id!);
                        },
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Icon(Icons.delete),
                        ),
                        child: ListTile(
                          leading: const Icon(
                            Icons.check,
                            color: kOrange,
                          ),
                          title: Text(
                            data.description![index],
                            style: const TextStyle(color: kWhiteText),
                          ),
                        ),
                      )
                    : const Spacer();
              },
            ),
          ],
        ),
      ),
    );
  }

  void newTodo(int? itemKey) {
    if (itemKey != null) {
      final TodoDataModel newTodo = TodoDataModel(
          description: updateTodoList, title: data.title, id: data.id);
      DbFunctions().updateTodo(itemKey, newTodo);
    }
  }

  void removetodo(int? index, int itemKey) {
    if (index != null) {
      removeTodoList.removeAt(index);
      final TodoDataModel newTodo = TodoDataModel(
          description: removeTodoList, title: data.title, id: data.id);
      DbFunctions().updateTodo(itemKey, newTodo);
    }
  }
}
