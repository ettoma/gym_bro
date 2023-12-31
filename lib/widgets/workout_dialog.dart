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
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  workout.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.amberAccent),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              workout.exercises[index].exercise,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
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
                                          children: [
                                            Text(
                                              set.reps.toString(),
                                              style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.tealAccent),
                                            ),
                                            Text(set.weight.toString(),
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold,
                                                ))
                                          ],
                                        ),
                                      )
                                  ],
                                ),
                              ),
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
      ),
    );
  }
}
