import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../database/data_model.dart';
import '../database/database_provider.dart';
import '../global/text.dart';
import '../views/live_workout.dart';

class CompletedWorkoutDialog extends StatelessWidget {
  final Size deviceSize;
  final CompletedWorkoutModel workout;

  const CompletedWorkoutDialog(
      {super.key, required this.deviceSize, required this.workout});

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(builder: (context, databaseProvider, _) {
      CompletedWorkoutModel w =
          databaseProvider.getCompletedWorkoutById(workout.id) ?? workout;
      return Dialog(
        child: SizedBox(
          width: deviceSize.width * 0.8,
          height: deviceSize.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    w.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        color: Colors.amberAccent),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemBuilder: (context, index) {
                        return Card(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  w.exercises[index].exercise,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: SizedBox(
                                    height: 70,
                                    child: ListView(
                                      scrollDirection: Axis.horizontal,
                                      children: [
                                        for (var set in w.exercises[index].sets)
                                          Container(
                                            margin: const EdgeInsets.only(
                                                top: 7, right: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(set.weight.toString(),
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                    )),
                                                Text(
                                                  '${set.reps.toString()}x',
                                                  style: const TextStyle(
                                                      fontSize: 16,
                                                      color: Colors
                                                          .lightBlueAccent),
                                                ),
                                              ],
                                            ),
                                          )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                      itemCount: w.exercises.length),
                ),
                TextButton(
                  child: const Text(
                    Buttons.startWorkout,
                    style: TextStyle(color: Colors.tealAccent),
                  ),
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => LiveWorkout(
                          workout: WorkoutModel(
                              id: w.id,
                              name: w.name,
                              exercises: w.exercises,
                              isFavourite: w.isFavourite),
                          workoutExerciseListLength: w.exercises.length,
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
