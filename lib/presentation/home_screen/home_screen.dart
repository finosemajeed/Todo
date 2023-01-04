import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/model/todo_data_model.dart';
import 'package:todo_hive/presentation/home_screen/add_task_screen.dart';
import 'package:todo_hive/presentation/home_screen/update_task.dart';
import 'package:todo_hive/presentation/home_screen/widgets/add_todo_card.dart';
import 'package:todo_hive/presentation/home_screen/widgets/custom_todo_card.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    DbFunctions().refreshItems();

    return SafeArea(
      child: ValueListenableBuilder(
          valueListenable: todoNotifier,
          builder: (context, value, _) {
            return ListView(
              children: [
                const Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text(
                    "My List",
                    style: TextStyle(
                      color: kWhite,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                      height: 1.2,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const ClampingScrollPhysics(),
                  children: [
                    ...value
                        .map((data) => GestureDetector(
                              onLongPress: () {
                                DbFunctions().deleteTodo(data.id!, context);
                              },
                              onTap: () {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: ((context) => UpdateTask(
                                          data: data,
                                        ))));
                              },
                              child: CustomTodoCard(
                                  title: data.title.toString(),
                                  todos: data.description?.length.toString() ??
                                      '0'),
                            ))
                        .toList(),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Task Type'),
                              actions: [
                                ElevatedButton(
                                    onPressed: () {
                                      _createTodo(context);
                                      titleController.text = "";
                                    },
                                    child: Text('confirm'))
                              ],
                              content: TextFormField(
                                  controller: titleController,
                                  decoration:
                                      InputDecoration(label: Text('title'))),
                            );
                          },
                        );
                      },
                      child: const AddTodoCard(),
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }

  void _createTodo(BuildContext ctx) {
    final title = titleController.text.trim();
    final TodoDataModel todo = TodoDataModel(title: title);
    DbFunctions().createTodo(todo);
    Navigator.pop(ctx);
  }
}
