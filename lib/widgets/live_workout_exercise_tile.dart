import 'package:flutter/material.dart';
import 'package:gym_bro/global/live_workout_provider.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:provider/provider.dart';

import '../database/data_model.dart';
import '../global/colours.dart';
import '../global/text.dart';

class LiveWorkoutExerciseTile extends StatefulWidget {
  ExerciseModel exercise;
  int exerciseIndex;
  LiveWorkoutExerciseTile(
      {super.key, required this.exercise, required this.exerciseIndex});

  @override
  State<LiveWorkoutExerciseTile> createState() =>
      _LiveWorkoutExerciseTileState();
}

class _LiveWorkoutExerciseTileState extends State<LiveWorkoutExerciseTile> {
  @override
  Widget build(BuildContext context) {
    String measureUnit =
        Provider.of<LocaleProvider>(context).getUnitMeasure == 'metric'
            ? ' kg'
            : ' lbs';

    String exerciseName =
        Provider.of<LiveWorkoutProvider>(context, listen: false)
            .workout!
            .exercises[widget.exerciseIndex]
            .exercise;

    List<WorkoutSet> setsState =
        Provider.of<LiveWorkoutProvider>(context, listen: false)
            .workout!
            .exercises[widget.exerciseIndex]
            .sets;

    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    Color getBorderColor(setIndex) {
      switch (brigthness) {
        case Brightness.dark:
          if (setsState[setIndex].isDone) {
            return Colors.greenAccent;
          }
          return ColorPalette.darkBox;
        case Brightness.light:
          if (widget.exercise.sets[setIndex].isDone) {
            return Colors.indigoAccent;
          }
          return ColorPalette.lightBox;
        default:
          return ColorPalette.lightBox;
      }
    }

    Color getSetColor(setIndex) {
      switch (brigthness) {
        case Brightness.dark:
          if (setsState[setIndex].isDone) {
            return Colors.white;
          }
          return Colors.white38;
        case Brightness.light:
          if (widget.exercise.sets[setIndex].isDone) {
            return Colors.indigoAccent;
          }
          return ColorPalette.lightBox;
        default:
          return ColorPalette.lightBox;
      }
    }

    Color getTitleBorderColor() {
      int countOfTotalSets = setsState.length;
      int countOfCompletedSets = 0;

      for (var set in setsState) {
        if (set.isDone) {
          countOfCompletedSets++;
        }
      }

      bool isExerciseCompleted = countOfCompletedSets == countOfTotalSets;

      switch (brigthness) {
        case Brightness.dark:
          if (isExerciseCompleted) {
            return Colors.greenAccent;
          }
          return ColorPalette.darkBox;
        case Brightness.light:
          if (isExerciseCompleted) {
            return Colors.indigoAccent;
          }
          return ColorPalette.lightBox;
        default:
          return ColorPalette.lightBox;
      }
    }

    return Column(
      children: [
        Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
            margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                      color: getTitleBorderColor(), offset: const Offset(3, 5))
                ],
                color: brigthness == Brightness.dark
                    ? ColorPalette.darkBG
                    : ColorPalette.lightBG,
                border: Border.all(
                  color: getTitleBorderColor(),
                  width: 3,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Text(exerciseName,
                style: const TextStyle(
                    fontWeight: FontWeight.w600, fontSize: 18))),
        SizedBox(
          height: 100,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Provider.of<LiveWorkoutProvider>(context, listen: false)
                      .addSetToExercise(
                          WorkoutSet(reps: 0, weight: 0, isDone: false),
                          widget.exerciseIndex);
                },
              ),
              Container(
                alignment: Alignment.center,
                width: deviceSize.width,
                child: Consumer<LiveWorkoutProvider>(
                    builder: (context, exerciseProvider, _) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: exerciseProvider
                          .workout!.exercises[widget.exerciseIndex].sets.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onLongPress: () {
                            TextEditingController repsController =
                                TextEditingController(
                                    text: exerciseProvider
                                        .workout!
                                        .exercises[widget.exerciseIndex]
                                        .sets[index]
                                        .reps
                                        .toString());
                            TextEditingController weightController =
                                TextEditingController(
                                    text: exerciseProvider
                                        .workout!
                                        .exercises[widget.exerciseIndex]
                                        .sets[index]
                                        .weight
                                        .toString());
                            showDialog(
                                barrierDismissible: true,
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    child: SizedBox(
                                        height: 300,
                                        width: 300,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                const Text(Titles.editSet),
                                                SizedBox(
                                                  width: 300,
                                                  height: 150,
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        width: 75,
                                                        child: TextField(
                                                            keyboardType:
                                                                TextInputType
                                                                    .number,
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  GeneralText
                                                                      .reps,
                                                            ),
                                                            controller:
                                                                repsController,
                                                            onSubmitted:
                                                                (value) {
                                                              widget
                                                                      .exercise
                                                                      .sets[index]
                                                                      .reps =
                                                                  int.parse(
                                                                      repsController
                                                                          .text);
                                                              widget
                                                                      .exercise
                                                                      .sets[index]
                                                                      .weight =
                                                                  double.parse(
                                                                      weightController
                                                                          .text);
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                      ),
                                                      Container(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(12),
                                                        width: 75,
                                                        child: TextField(
                                                            keyboardType:
                                                                const TextInputType
                                                                    .numberWithOptions(
                                                                    decimal:
                                                                        true),
                                                            decoration:
                                                                const InputDecoration(
                                                              labelText:
                                                                  GeneralText
                                                                      .weight,
                                                            ),
                                                            controller:
                                                                weightController,
                                                            onSubmitted:
                                                                (value) {
                                                              widget
                                                                      .exercise
                                                                      .sets[index]
                                                                      .reps =
                                                                  int.parse(
                                                                      repsController
                                                                          .text);
                                                              widget
                                                                      .exercise
                                                                      .sets[index]
                                                                      .weight =
                                                                  double.parse(
                                                                      weightController
                                                                          .text);
                                                              setState(() {});
                                                              Navigator.of(
                                                                      context)
                                                                  .pop();
                                                            }),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                IconButton(
                                                  icon: const Icon(
                                                    Icons.check,
                                                    color: Colors.tealAccent,
                                                  ),
                                                  onPressed: () {
                                                    setState(() {
                                                      widget
                                                              .exercise
                                                              .sets[index]
                                                              .reps =
                                                          int.parse(
                                                              repsController
                                                                  .text);
                                                      widget
                                                              .exercise
                                                              .sets[index]
                                                              .weight =
                                                          double.parse(
                                                              weightController
                                                                  .text);
                                                    });

                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              ]),
                                        )),
                                  );
                                });
                          },
                          onTap: () {
                            setState(() {
                              exerciseProvider
                                      .workout!
                                      .exercises[widget.exerciseIndex]
                                      .sets[index]
                                      .isDone =
                                  !exerciseProvider
                                      .workout!
                                      .exercises[widget.exerciseIndex]
                                      .sets[index]
                                      .isDone;
                            });
                          },
                          child: Container(
                            width: 100,
                            margin: const EdgeInsets.only(left: 10, top: 10),
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(
                                  color: getBorderColor(index),
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                    padding:
                                        const EdgeInsets.symmetric(vertical: 5),
                                    child: Text(
                                      '${exerciseProvider.workout!.exercises[widget.exerciseIndex].sets[index].weight}$measureUnit',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: getSetColor(index)),
                                      overflow: TextOverflow.fade,
                                      softWrap: false,
                                    )),
                                Container(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 5, horizontal: 10),
                                    child: Text(
                                        '${exerciseProvider.workout!.exercises[widget.exerciseIndex].sets[index].reps.toString()} x',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: getSetColor(index),
                                            fontSize: 18))),
                              ],
                            ),
                          ),
                        );
                      });
                }),
              )
            ],
          ),
        ),
      ],
    );
  }
}
