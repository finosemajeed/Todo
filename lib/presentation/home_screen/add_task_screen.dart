import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';
import 'package:todo_hive/database/no.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DbFunctions().refreshItems();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: kWhite),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                style: TextStyle(color: kWhite),
                controller: titleController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Title",
                  labelStyle: TextStyle(
                    color: kOrange,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return "Please enter your task title";
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                style: TextStyle(color: kWhite),
                controller: descriptionController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Description",
                  labelStyle: TextStyle(
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
            SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: Size(150, 40),
              ),
              onPressed: () {
                createTodo();
                titleController.text = "";
                descriptionController.text = "";
              },
              child: Text("Confirm"),
            ),
          ],
        ),
      ),
    );
  }

  void updateTodo(int itemKey) {
    if (itemKey != null) {
      final existingItem =
          todoNotifier.value.firstWher((element) => element['id'] == itemKey);
      titleController.text = existingItem['title'];
      descriptionController.text = existingItem['description'];
    }
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final TodoDataModel newTodo =
        TodoDataModel(title: title, description: description);
    DbFunctions().updateTodo(itemKey, newTodo);
  }

  void createTodo() {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final TodoDataModel todo =
        TodoDataModel(title: title, description: description);
    DbFunctions().createTodo(todo);
  }
}
