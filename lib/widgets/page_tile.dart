import 'package:flutter/material.dart';
import 'package:gym_bro/global/theme_provider.dart';
import 'package:gym_bro/views/logs_view.dart';
import 'package:gym_bro/views/my_workouts.dart';
import 'package:gym_bro/views/stats_view.dart';

import '../global/text.dart';
import '../views/quick_workout.dart';

class PageTile extends StatelessWidget {
  final String pageTitle;
  const PageTile({super.key, required this.pageTitle});

  @override
  Widget build(BuildContext context) {
    Brightness brightness = MediaQuery.of(context).platformBrightness;
    return Container(
      height: 100,
      width: 100,
      margin: const EdgeInsets.all(10),
      child: TextButton(
        style: brightness == Brightness.dark
            ? ThemeProvider()
                .darkMode
                .textButtonTheme
                .style!
                .copyWith(alignment: Alignment.centerRight)
            : ThemeProvider()
                .lightMode
                .textButtonTheme
                .style!
                .copyWith(alignment: Alignment.centerRight),
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
      return const LogsPage();
    case PageNames.stats:
      return const StatsPage();
    case PageNames.quickWorkout:
      return const QuickWorkout();

    default:
      return const MyWorkouts();
  }
}
