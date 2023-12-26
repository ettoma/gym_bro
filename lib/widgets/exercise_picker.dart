import 'package:flutter/material.dart';
import 'package:gym_bro/global/exercise_picker_provider.dart';
import 'package:provider/provider.dart';

import '../global/quick_workout_exercise_picker_provider.dart';
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
            color: Colors.red,
            padding: const EdgeInsets.all(8.0),
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: const Text(
              Titles.exercisePickerTitle,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) {
              return Container(
                width: constraints.maxWidth,
                height: 400,
                // height: 200,
                color: Colors.limeAccent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      color: Colors.red,
                      margin: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      padding: const EdgeInsets.all(8.0),
                      child: DropdownMenu(
                          width: 150,
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
                          // width: MediaQuery.of(context).size.width * 0.75,
                          dropdownMenuEntries: muscleGroups
                              .map<DropdownMenuEntry<String>>((String value) {
                            return DropdownMenuEntry(
                              label: value,
                              value: value,
                            );
                          }).toList()),
                    ),
                    Opacity(
                      opacity: muscleGroupController.text == '' ? 1 : 1,
                      child: Container(
                        color: Colors.blue,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        padding: const EdgeInsets.all(8.0),
                        child: muscleGroupController.text == ''
                            ? null
                            : DropdownMenu(
                                width: 150,
                                controller: exerciseController,
                                inputDecorationTheme:
                                    const InputDecorationTheme(
                                  border: InputBorder.none,
                                ),
                                menuStyle: MenuStyle(
                                    padding:
                                        MaterialStateProperty.all<EdgeInsets>(
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
                                // width: MediaQuery.of(context).size.width * 0.75,
                                dropdownMenuEntries:
                                    getExercisesForMuscleGroup()),
                      ),
                    ),
                    Opacity(
                        opacity: exerciseController.text == '' ? 0 : 1,
                        child: SizedBox(
                          height: 400,
                          width: 200,
                          child: ListView.builder(
                            itemCount: setsCount,
                            itemBuilder: (context, index) {
                              return SizedBox(
                                height: 200,
                                width: 200,
                                child: Row(
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
                                            suffixIcon: Icon(
                                                Icons.onetwothree_rounded,
                                                color: Colors.tealAccent),
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
                                            suffixIcon: Icon(
                                              Icons.onetwothree_rounded,
                                              color: Colors.tealAccent,
                                            ),
                                          ),
                                        ),
                                      ),
                                      weightControllers.length - 1 == index
                                          ? IconButton(
                                              onPressed: () {
                                                setState(() {
                                                  repsControllers.add(
                                                      TextEditingController());
                                                  weightControllers.add(
                                                      TextEditingController());
                                                  setsCount++;
                                                });
                                              },
                                              icon: const Icon(Icons.add))
                                          : Container()
                                    ]),
                              );
                            },
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.check_rounded,
              color: Colors.tealAccent,
            ),
            onPressed: () {
              if (exerciseController.text == '' ||
                  muscleGroupController.text == '' ||
                  repsControllers[0].text == '' ||
                  weightControllers[0].text == '') {
                showDialog(
                    context: context,
                    builder: (context) {
                      return const AlertDialog(
                        title: Text('error',
                            style: TextStyle(color: Colors.amberAccent)),
                        content: Padding(
                          padding: EdgeInsets.all(20),
                          child: Text(
                            'please fill in all fields',
                          ),
                        ),
                      );
                    });
                return;
              } else {
                Provider.of<ExercisePickerProvider>(context, listen: false)
                    .setExercise(Exercise(
                        name: exerciseController.text,
                        muscleGroup: muscleGroupController.text,
                        isExerciseDone: false,
                        sets: [
                      for (int i = 0; i < setsCount; i++)
                        WorkoutSet(
                            reps: int.parse(repsControllers[i].text),
                            weight: double.parse(weightControllers[i].text),
                            isDone: false)
                    ]));
                Navigator.pop(context);
              }
            },
          )
        ]);
  }
}
