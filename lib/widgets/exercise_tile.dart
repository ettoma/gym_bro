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

    Size deviceSize = MediaQuery.of(context).size;

    return SizedBox(
        height: 150,
        child: Column(
          children: [
            Container(
                alignment: Alignment.center,
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                margin: const EdgeInsets.only(top: 5, left: 10, right: 10),
                width: deviceSize.width,
                decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.transparent.withOpacity(0.2),
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(10)),
                child: Text(exercises['exercise'])),
            Container(
              alignment: Alignment.center,
              height: 100,
              child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: exercises['sets'],
                  itemBuilder: (context, index) {
                    return Container(
                      width: 100,
                      margin:
                          const EdgeInsets.only(left: 10, bottom: 5, top: 5),
                      padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.transparent.withOpacity(0.2),
                            width: 2,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              child: Text(repsList[index].toString())),
                          Container(
                            height: 5,
                            width: 5,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border:
                                    Border.all(color: Colors.black, width: 1),
                                borderRadius: BorderRadius.circular(25)),
                          ),
                          Container(
                              padding: const EdgeInsets.symmetric(vertical: 5),
                              child: Text(
                                '${weightsList[index].toString()}$measureUnit',
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
