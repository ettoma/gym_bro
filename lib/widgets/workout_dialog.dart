import 'package:flutter/material.dart';

import '../database/data_model.dart';
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
              // Container(
              //   height: 1,
              //   width: deviceSize.width * 0.8,
              //   color: Colors.white10,
              //   margin: const EdgeInsets.only(bottom: 10),
              // ),
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
            ],
          ),
        ),
      ),
    );
  }
}
