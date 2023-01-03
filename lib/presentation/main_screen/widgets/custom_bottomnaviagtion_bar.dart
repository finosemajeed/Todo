import 'package:flutter/material.dart';
import 'package:todo_hive/core/color_config.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: ((context, newIndex, _) => BottomNavigationBar(
              elevation: 0,
              selectedItemColor: kOrange,
              unselectedItemColor: kGrey,
              backgroundColor: Colors.transparent,
              currentIndex: newIndex,
              onTap: ((index) {
                indexChangeNotifier.value = index;
              }),
              items: const [
                BottomNavigationBarItem(
                    icon: Icon(Icons.home_filled), label: ""),
                BottomNavigationBarItem(icon: Icon(Icons.start), label: "")
              ],
            )));
  }
}
