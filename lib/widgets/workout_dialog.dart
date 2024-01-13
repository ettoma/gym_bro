import 'package:flutter/material.dart';
import 'package:gym_bro/global/exercise_picker_provider.dart';
import 'package:gym_bro/views/workout_builder.dart';
import 'package:provider/provider.dart';

import '../database/data_model.dart';
import '../global/quick_workout_exercise_picker_provider.dart' as qwep;
import '../global/text.dart';
import '../views/live_workout.dart';

class WorkoutDialog extends StatelessWidget {
  final Size deviceSize;
  final WorkoutModel workout;

  const WorkoutDialog(
      {super.key, required this.deviceSize, required this.workout});

  @override
  Widget build(BuildContext context) {
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
                  workout.name,
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
                              horizontal: 15, vertical: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                workout.exercises[index].exercise,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: SizedBox(
                                  height: 70,
                                  child: ListView(
                                    scrollDirection: Axis.horizontal,
                                    children: [
                                      for (var set
                                          in workout.exercises[index].sets)
                                        Container(
                                          margin: const EdgeInsets.only(
                                              top: 7, right: 5),
                                          padding: const EdgeInsets.all(5),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(set.weight.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16,
                                                    // fontWeight: FontWeight.bold,
                                                  )),
                                              Text(
                                                '${set.reps.toString()}x',
                                                style: const TextStyle(
                                                    fontSize: 16,
                                                    // fontWeight: FontWeight.bold,
                                                    color:
                                                        Colors.lightBlueAccent),
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
                    itemCount: workout.exercises.length),
              ),
              TextButton(
                child: const Text(
                  Buttons.startWorkout,
                  style: TextStyle(color: Colors.tealAccent),
                ),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (context) => LiveWorkout(workout: workout)),
                  );
                },
              ),
              TextButton(
                child: Text('edit'),
                onPressed: () {
                  for (var exercise in workout.exercises) {
                    Provider.of<ExercisePickerProvider>(context, listen: false)
                        .setExercise(qwep.Exercise(
                            name: exercise.exercise,
                            muscleGroup: exercise.muscleGroup,
                            isExerciseDone: false,
                            sets: [
                          for (int i = 0; i < exercise.sets.length; i++)
                            qwep.WorkoutSet(
                                reps: exercise.sets[i].reps,
                                weight: exercise.sets[i].weight,
                                isDone: false)
                        ]));
                  }

                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) =>
                          WorkoutBuilder(existingWorkoutTitle: workout.name)));
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
