import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/widgets/app_bar.dart';

import 'workout_builder.dart';

class MyWorkouts extends StatefulWidget {
  const MyWorkouts({super.key});

  @override
  State<MyWorkouts> createState() => _MyWorkoutsState();
}

class _MyWorkoutsState extends State<MyWorkouts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.myWorkouts,
      ),
      body: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: TextButton(
          child: const Text(Titles.createWorkout),
          onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => const WorkoutBuilder()));
          },
        ),
      ),
    );
  }
}
