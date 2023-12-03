import 'package:flutter/material.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:gym_bro/global/quick_workout_exercise_picker_provider.dart';
import 'package:provider/provider.dart';

import '../global/colours.dart';

class WorkoutExerciseTile extends StatefulWidget {
  Exercise exercise;
  int exerciseIndex;
  WorkoutExerciseTile(
      {super.key, required this.exercise, required this.exerciseIndex});

  @override
  State<WorkoutExerciseTile> createState() => _WorkoutExerciseTileState();
}

class _WorkoutExerciseTileState extends State<WorkoutExerciseTile> {
  @override
  Widget build(BuildContext context) {
    String measureUnit =
        Provider.of<LocaleProvider>(context).getUnitMeasure == 'metric'
            ? ' kg'
            : ' lbs';

    List<WorkoutSet> sets = widget.exercise.sets;

    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    Color getBorderColor(setIndex) {
      switch (brigthness) {
        case Brightness.dark:
          if (widget.exercise.sets[setIndex].isDone) {
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

    Color getTitleBorderColor() {
      int countOfTotalSets = sets.length;
      int countOfCompletedSets = 0;

      for (var set in sets) {
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

    return SizedBox(
        height: 175,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                width: deviceSize.width,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: getTitleBorderColor(),
                          offset: const Offset(3, 5))
                    ],
                    color: brigthness == Brightness.dark
                        ? ColorPalette.darkBG
                        : ColorPalette.lightBG,
                    border: Border.all(
                      color: getTitleBorderColor(),
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(widget.exercise.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18))),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.exercise.sets.length,
                  itemBuilder: (context, index) {
                    return Consumer<QuickWorkoutExercisePickerProvider>(
                      builder: (context, provider, _) => GestureDetector(
                        onTap: () {
                          provider.setIsDone(widget.exerciseIndex, index,
                              !widget.exercise.sets[index].isDone);
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
                            children: [
                              Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  child: Text(sets[index].reps.toString(),
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16))),
                              Container(
                                height: 5,
                                width: 5,
                                decoration: BoxDecoration(
                                    color: brigthness == Brightness.dark
                                        ? ColorPalette.darkText
                                        : ColorPalette.lightText,
                                    border: Border.all(
                                        color: brigthness == Brightness.dark
                                            ? ColorPalette.darkText
                                            : ColorPalette.lightText,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(25)),
                              ),
                              Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 5),
                                  child: Text(
                                    '${sets[index].weight}$measureUnit',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                    overflow: TextOverflow.fade,
                                    softWrap: false,
                                  )),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
