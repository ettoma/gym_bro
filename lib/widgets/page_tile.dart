import 'package:flutter/material.dart';
import 'package:gym_bro/views/my_workouts.dart';

import '../global/text.dart';

class PageTile extends StatelessWidget {
  final String pageTitle;
  const PageTile({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: TextButton(
        style: Theme.of(context).textButtonTheme.style!.copyWith(
            alignment: Alignment.centerRight,
            foregroundColor: pageTitle == 'quick start'
                ? MaterialStateColor.resolveWith((states) => Colors.red)
                : null),
        onPressed: () {
          Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => _switchPage(pageTitle)));
        },
        child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Text(
              pageTitle,
            )),
      ),
    );
  }
}

Widget _switchPage(String pageTitle) {
  switch (pageTitle) {
    case PageNames.myWorkouts:
      return const MyWorkouts();
    case PageNames.logs:
      return const MyWorkouts();
    case PageNames.profile:
      return const MyWorkouts();
    case PageNames.quickStart:
      return const MyWorkouts();
    default:
      return const MyWorkouts();
  }
}
