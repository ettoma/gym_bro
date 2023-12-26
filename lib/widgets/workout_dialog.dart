import 'package:flutter/material.dart';

import '../database/data_model.dart';

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
        height: deviceSize.height * 0.5,
        child: Column(
          children: [
            Text(workout.name),
            Expanded(
              child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(workout.exercises[index].exercise),
                          Row(
                            children: [
                              for (var set in workout.exercises[index].sets)
                                Container(
                                  child: Column(
                                    children: [
                                      Text(set.reps.toString()),
                                      Text(set.weight.toString())
                                    ],
                                  ),
                                )
                            ],
                          )
                        ],
                      ),
                    );
                  },
                  itemCount: workout.exercises.length),
            ),
          ],
        ),
      ),
    );
  }
}
