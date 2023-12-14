import 'package:flutter/material.dart';

import '../database/data_model.dart';
import '../global/colours.dart';

class WorkoutTile extends StatelessWidget {
  WorkoutModel workout;
  WorkoutTile({super.key, required this.workout});

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    Color getBorderColor() {
      switch (brigthness) {
        case Brightness.dark:
          return ColorPalette.darkBox;
        case Brightness.light:
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
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
              margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
              width: deviceSize.width,
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                        color: getBorderColor(), offset: const Offset(3, 5))
                  ],
                  color: brigthness == Brightness.dark
                      ? ColorPalette.darkBG
                      : ColorPalette.lightBG,
                  border: Border.all(
                    color: getBorderColor(),
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10)),
              child: Text(workout.name,
                  style: const TextStyle(
                      fontWeight: FontWeight.w600, fontSize: 18))),
          Container(
            alignment: Alignment.center,
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: workout.exercises.length,
              itemBuilder: (context, index) {
                return Container(
                  width: 100,
                  margin: const EdgeInsets.only(left: 10, top: 10),
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: getBorderColor(),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 5, horizontal: 10),
                      child: Text(workout.exercises[index].exercise,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 16))),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
