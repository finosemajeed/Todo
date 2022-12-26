import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';

class AddTodoCard extends StatelessWidget {
  const AddTodoCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.width / 2.5,
        width: MediaQuery.of(context).size.width / 2.5,
        child: DottedBorder(
          color: kGrey,
          dashPattern: const [10, 5],
          child: const Center(
            child: Icon(
              Icons.add,
              size: 50.0,
              color: kGrey,
            ),
          ),
        ),
      ),
    );
  }
}
