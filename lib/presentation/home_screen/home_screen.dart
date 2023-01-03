import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/presentation/home_screen/add_task_screen.dart';
import 'package:todo_hive/presentation/home_screen/widgets/add_todo_card.dart';
import 'package:todo_hive/presentation/home_screen/widgets/custom_todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  // gridDelegate:
                  //     SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                  // itemBuilder: ((context, index) => CustomTodoCard()),
                  children: [
                    ...value
                        .map((data) => GestureDetector(
                              onLongPress: () {
                                DbFunctions().deleteTodo(data.id!, context);
                              },
                              child: CustomTodoCard(
                                  title: data.title, todos: data.description),
                            ))
                        .toList(),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => AddTaskScreen())));
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
}
