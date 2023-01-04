import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';

class AddTaskScreen extends StatelessWidget {
  AddTaskScreen({super.key});

  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // DbFunctions().refreshItems();
    return Scaffold(
      backgroundColor: backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: kWhite),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                style: const TextStyle(color: kWhite),
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
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: TextFormField(
                style: const TextStyle(color: kWhite),
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
            const SizedBox(height: 10),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: kBlueButton,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                minimumSize: const Size(150, 40),
              ),
              onPressed: () {
                createTodo(context);
                titleController.text = "";
                descriptionController.text = "";
              },
              child: const Text("Confirm"),
            ),
            SizedBox(height: 20),
            Wrap(
              children: [
                Checkbox(value: true, onChanged: ((value) => {})),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.33,
                  child: TextFormField(
                    style: TextStyle(color: Colors.grey),
                    decoration: const InputDecoration(
                      labelText: "Title",
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Please enter your task title";
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                    onPressed: (() => {}),
                    icon: Icon(
                      Icons.check,
                      color: kOrange,
                    ))
              ],
            )
          ],
        ),
      ),
    );
  }

  void createTodo(BuildContext ctx) {
    final title = titleController.text.trim();
    final description = descriptionController.text.trim();
    final List<String> data = [];
    data.add(description);
    final TodoDataModel todo = TodoDataModel(title: title, description: data);
    DbFunctions().createTodo(todo);
    Navigator.pop(ctx);
  }
}
