import 'package:flutter/material.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/exercise_picker.dart';
import 'package:gym_bro/widgets/exercise_tile.dart';

import '../global/text.dart';

class WorkoutBuilder extends StatefulWidget {
  const WorkoutBuilder({super.key});

  @override
  State<WorkoutBuilder> createState() => _WorkoutBuilderState();
}

class _WorkoutBuilderState extends State<WorkoutBuilder> {
  TextEditingController workoutTitleController = TextEditingController();

  List<ExerciseTile> exerciseList = [
    ExerciseTile(
        exerciseName: ExerciseNames.benchPress, reps: 10, weight: 15, sets: 3),
    ExerciseTile(
      exerciseName: ExerciseNames.pullUps,
      reps: 20,
      weight: 25,
      sets: 4,
    )
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.workoutBuilder,
      ),
      body: Column(
        children: [
          TextField(
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 20),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                hintText: HelperText.workoutTitle,
                hintStyle: TextStyle(fontSize: 16)),
            controller: workoutTitleController,
          ),
          Column(
            children: exerciseList,
          ),
          Container(
              width: MediaQuery.of(context).size.width * 0.7,
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  borderRadius: BorderRadius.circular(25)),
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
              child: TextButton(
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(HelperText.addExercise),
                      Icon(Icons.add),
                    ],
                  ),
                  onPressed: () {
                    showModalBottomSheet(
                        isScrollControlled: true,
                        context: (context),
                        builder: (context) {
                          return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.9,
                              child: ExercisePicker());
                        });
                  }))
        ],
      ),
    );
  }
}
