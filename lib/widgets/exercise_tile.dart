import 'package:flutter/material.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:gym_bro/global/quick_workout_exercise_picker_provider.dart';
import 'package:provider/provider.dart';

import '../global/colours.dart';

class ExerciseTile extends StatelessWidget {
  Exercise exercise;
  ExerciseTile({
    super.key,
    required this.exercise,
  });

  @override
  Widget build(BuildContext context) {
    String measureUnit =
        Provider.of<LocaleProvider>(context).getUnitMeasure == 'metric'
            ? ' kg'
            : ' lbs';

    List<WorkoutSet> sets = exercise.sets;

    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

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
                          color: brigthness == Brightness.dark
                              ? ColorPalette.darkBox
                              : ColorPalette.lightBox,
                          offset: const Offset(3, 5))
                    ],
                    color: brigthness == Brightness.dark
                        ? ColorPalette.darkBG
                        : ColorPalette.lightBG,
                    border: Border.all(
                      color: brigthness == Brightness.dark
                          ? ColorPalette.darkBox
                          : ColorPalette.lightBox,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(exercise.name,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 18))),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: exercise.sets.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin: const EdgeInsets.only(left: 10, top: 10),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: brigthness == Brightness.dark
                                ? ColorPalette.darkBox
                                : ColorPalette.lightBox,
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
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '${sets[index].weight.toString()}$measureUnit',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 16),
                                overflow: TextOverflow.fade,
                                softWrap: false,
                              )),
                        ],
                      ),
                    );
                  }),
            ),
          ],
        ));
  }
}
