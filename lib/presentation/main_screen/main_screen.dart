import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';
import 'package:todo_hive/database/db_function.dart';
import 'package:todo_hive/database/no.dart';
import 'package:todo_hive/presentation/home_screen/add_task_screen.dart';
import 'package:todo_hive/presentation/home_screen/home_screen.dart';
import 'package:todo_hive/presentation/main_screen/widgets/custom_bottomnaviagtion_bar.dart';
import 'package:todo_hive/presentation/status_screen/status_screen.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  final _pages = [
    HomeScreen(),
    StatusScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    DbFunctions().refreshItems();
    return Scaffold(
      drawer: Drawer(),
      backgroundColor: backGroundColor,
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CupertinoSwitch(
              trackColor: kLightYellow,
              value: false,
              onChanged: ((value) => {}),
            ),
          )
        ],
        iconTheme: IconThemeData(color: kOrange),
        backgroundColor: kAppbarColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30))),
      ),
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: ((context, index, child) => _pages[index]),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 20,
        onPressed: () => {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: ((context) => AddTaskScreen())))
        },
        backgroundColor: kBlueButton,
        child: Icon(
          Icons.add,
          color: kBlack,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      bottomNavigationBar: CustomBottomNavigationBar(),
    );
  }
}
