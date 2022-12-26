import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/presentation/home_screen/add_task_screen.dart';
import 'package:todo_hive/presentation/home_screen/widgets/add_todo_card.dart';
import 'package:todo_hive/presentation/home_screen/widgets/custom_todo_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: ListView(
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
              const CustomTodoCard(
                title: 'Groceries',
                todos: '3',
              ),
              const CustomTodoCard(
                title: 'Workout',
                todos: '2',
              ),
              GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: ((context) => AddTaskScreen())));
                },
                child: AddTodoCard(),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
