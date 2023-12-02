import 'package:flutter/material.dart';
import 'package:gym_bro/global/exercise_picker_provider.dart';
import 'package:provider/provider.dart';

import '../global/text.dart';

class ExercisePicker extends StatefulWidget {
  const ExercisePicker({super.key});

  @override
  State<ExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends State<ExercisePicker> {
  TextEditingController muscleGroupController = TextEditingController();
  TextEditingController exerciseController = TextEditingController();
  List<TextEditingController> repsControllers = [TextEditingController()];
  List<TextEditingController> weightControllers = [TextEditingController()];

  FocusNode focusReps = FocusNode();

  int setsCount = 1;

  @override
  Widget build(BuildContext context) {
    List<String> muscleGroups = MuscleGroups.muscleGroups;

    List<DropdownMenuEntry<String>> getExercisesForMuscleGroup() {
      List<String> chestExercises = ChestExercises.exercises;
      List<String> backExercises = BackExercises.exercises;

      String muscleGroup = muscleGroupController.text;

      switch (muscleGroup) {
        case 'chest':
          return chestExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();

        case 'back':
          return backExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        default:
          return [];
      }
    }

    muscleGroupController.addListener(() {
      getExercisesForMuscleGroup();
    });

    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: const Text(
              Titles.exercisePickerTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Expanded(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                padding: const EdgeInsets.all(8.0),
                child: DropdownMenu(
                    controller: muscleGroupController,
                    inputDecorationTheme: const InputDecorationTheme(
                      border: InputBorder.none,
                    ),
                    menuStyle: MenuStyle(
                        padding: MaterialStateProperty.all<EdgeInsets>(
                            const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10))),
                    label: const Text(DropdownTitles.muscleGroup),
                    onSelected: (value) {
                      setState(() {
                        exerciseController.clear();
                        repsControllers[0].clear();
                        weightControllers[0].clear();
                        muscleGroupController.text = value.toString();
                      });
                    },
                    width: MediaQuery.of(context).size.width * 0.95,
                    dropdownMenuEntries: muscleGroups
                        .map<DropdownMenuEntry<String>>((String value) {
                      return DropdownMenuEntry(
                        label: value,
                        value: value,
                      );
                    }).toList()),
              ),
              Opacity(
                opacity: muscleGroupController.text == '' ? 0 : 1,
                child: Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(8.0),
                  child: muscleGroupController.text == ''
                      ? null
                      : DropdownMenu(
                          controller: exerciseController,
                          inputDecorationTheme: const InputDecorationTheme(
                            border: InputBorder.none,
                          ),
                          menuStyle: MenuStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 20))),
                          label: const Text(DropdownTitles.exercise),
                          onSelected: (value) {
                            setState(() {
                              weightControllers[0].clear();
                              repsControllers[0].clear();
                              exerciseController.text = value.toString();
                            });
                          },
                          width: MediaQuery.of(context).size.width * 0.95,
                          dropdownMenuEntries: getExercisesForMuscleGroup()),
                ),
              ),
              Opacity(
                  opacity: exerciseController.text == '' ? 0 : 1,
                  child: SizedBox(
                    height: 400,
                    child: ListView.builder(
                      itemCount: setsCount,
                      itemBuilder: (context, index) {
                        return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 100,
                                child: TextField(
                                  maxLines: 1,
                                  maxLength: 3,
                                  enableSuggestions: false,
                                  controller: repsControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    helperText: DropdownTitles.reps,
                                    suffixIcon: Icon(Icons.onetwothree_rounded),
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                width: 100,
                                child: TextField(
                                  maxLines: 1,
                                  maxLength: 3,
                                  enableSuggestions: false,
                                  controller: weightControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: const InputDecoration(
                                    counterText: '',
                                    helperText: DropdownTitles.weight,
                                    suffixIcon: Icon(Icons.onetwothree_rounded),
                                  ),
                                ),
                              ),
                              weightControllers.length - 1 == index
                                  ? IconButton(
                                      onPressed: () {
                                        setState(() {
                                          repsControllers
                                              .add(TextEditingController());
                                          weightControllers
                                              .add(TextEditingController());
                                          setsCount++;
                                        });
                                      },
                                      icon: const Icon(Icons.add))
                                  : Container()
                            ]);
                      },
                    ),
                  )),
              IconButton(
                icon: const Icon(Icons.coffee_rounded),
                onPressed: () {
                  Provider.of<ExercisePickerProvider>(context, listen: false)
                      .setExercise({
                    'muscleGroup': muscleGroupController.text,
                    'exercise': exerciseController.text,
                    'reps': repsControllers
                        .map((e) => {int.parse(e.text)})
                        .toList(),
                    'weight': weightControllers
                        .map((e) => {double.parse(e.text)})
                        .toList(),
                    'sets': setsCount
                  });
                  Navigator.pop(context);
                },
              )
            ]),
          )
        ]);
  }
}
