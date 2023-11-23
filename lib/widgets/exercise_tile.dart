import 'package:flutter/material.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatelessWidget {
  String exerciseName;
  int reps;
  double weight;
  int sets;
  ExerciseTile(
      {super.key,
      required this.exerciseName,
      required this.reps,
      required this.sets,
      this.weight = 0});

  @override
  Widget build(BuildContext context) {
    String measureUnit =
        Provider.of<LocaleProvider>(context).getUnitMeasure == 'metric'
            ? ' kg'
            : ' lbs';

    return Container(
        child: Column(
      children: [
        Text(exerciseName),
        Container(
          height: 100,
          child: ListView.builder(
              itemCount: sets,
              itemBuilder: (context, idex) {
                return Row(
                  children: [
                    Text(reps.toString()),
                    Text(weight.toString() + measureUnit)
                  ],
                );
              }),
        ),
      ],
    ));
  }
}
