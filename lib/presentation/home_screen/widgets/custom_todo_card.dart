import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';

class CustomTodoCard extends StatelessWidget {
  const CustomTodoCard({
    Key? key,
    required this.title,
    required this.todos,
  }) : super(key: key);

  final String title;
  final String todos;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          color: kWhite,
          borderRadius: const BorderRadius.only(
              bottomRight: Radius.circular(70.0),
              bottomLeft: Radius.circular(25.0)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.cyclone,
              color: kOrange,
              size: 50,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: kBlack.withOpacity(0.8),
                    fontWeight: FontWeight.w800,
                    fontSize: 24,
                    height: 1.2,
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                Text(
                  "$todos Task",
                  style: const TextStyle(
                    color: kGrey,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    height: 1.2,
                    letterSpacing: 1.5,
                  ),
                ),
              ],
            ),
          )
        ]),
      ),
    );
  }
}
