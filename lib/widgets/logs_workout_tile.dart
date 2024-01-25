import 'package:flutter/material.dart';

import '../database/data_model.dart';
import '../global/colours.dart';

class LogsWorkoutTile extends StatelessWidget {
  CompletedWorkoutModel workout;

  LogsWorkoutTile({super.key, required this.workout});

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

    DateTime workoutDate = DateTime.parse(workout.completedOn).toLocal();

    String getWorkoutDuration() {
      String seconds = workout.duration;

      Duration duration = Duration(seconds: int.parse(seconds));

      if (duration.inHours > 0) {
        return '${duration.inHours}h ${duration.inMinutes % 60}m ${duration.inSeconds % 60}s';
      } else if (duration.inMinutes > 0) {
        return '${duration.inMinutes}m ${duration.inSeconds % 60}s';
      } else {
        return '${duration.inSeconds}s';
      }
    }

    String workoutDateString =
        '${workoutDate.day}.${workoutDate.month}.${workoutDate.year} ${workoutDate.hour}:${workoutDate.minute}';

    return SizedBox(
      height: 100,
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(workout.name,
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18)),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text(workoutDateString),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 2),
                        child: Text(getWorkoutDuration()),
                      ),
                    ],
                  )
                ],
              )),
        ],
      ),
    );
  }
}
