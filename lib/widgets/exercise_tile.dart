import 'package:flutter/material.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:provider/provider.dart';

class ExerciseTile extends StatelessWidget {
  // String exerciseName;
  // dynamic reps;
  // dynamic weight;
  // int sets;

  Map<String, dynamic> exercises;
  ExerciseTile({
    super.key,
    required this.exercises,
  });

  @override
  Widget build(BuildContext context) {
    String measureUnit =
        Provider.of<LocaleProvider>(context).getUnitMeasure == 'metric'
            ? ' kg'
            : ' lbs';

    List<Set<int>> reps = exercises['reps'];
    List<int> repsList = reps.expand((rep) => rep).toList();
    List<Set<double>> weights = exercises['weight'];
    List<double> weightsList = weights.expand((weight) => weight).toList();

    // print(setsList);
    // List<int> reps = exercises['reps'].toList();

    return Container(
        child: Column(
      children: [
        Text(exercises['exercise']),
        Container(
          height: 100,
          child: ListView.builder(
              itemCount: exercises['sets'],
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Text(repsList[index].toString()),
                    Text('${weightsList[index].toString()} $measureUnit')
                  ],
                );
              }),
        ),
      ],
    ));
  }
}
