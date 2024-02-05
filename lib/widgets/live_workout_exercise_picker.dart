import 'package:flutter/material.dart';
// import 'package:gym_bro/global/exercise_picker_provider.dart';
import 'package:gym_bro/global/live_workout_provider.dart';
import 'package:provider/provider.dart';

import '../database/data_model.dart';
import '../global/exercise_list.dart';
// import '../global/quick_workout_exercise_picker_provider.dart';
import '../global/text.dart';

class LiveWorkoutExercisePicker extends StatefulWidget {
  LiveWorkoutExercisePicker({super.key});

  @override
  State<LiveWorkoutExercisePicker> createState() => _ExercisePickerState();
}

class _ExercisePickerState extends State<LiveWorkoutExercisePicker> {
  late TextEditingController muscleGroupController;
  late TextEditingController exerciseController;
  late List<TextEditingController> repsControllers;
  late List<TextEditingController> weightControllers;

  int setsCount = 1;

  List<String> chestExercises = [];
  List<String> absExercises = [];
  List<String> calvesExercises = [];
  List<String> shouldersExercises = [];
  List<String> bicepsExercises = [];
  List<String> tricepsExercises = [];
  List<String> quadsExercises = [];
  List<String> hamstringsExercises = [];
  List<String> latsExercises = [];

  Future<void> updateAllExercises() async {
    chestExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.chest);
    latsExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.lats);
    absExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.abs);
    hamstringsExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.hamstrings);
    bicepsExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.biceps);
    tricepsExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.triceps);
    shouldersExercises =
        await ExerciseList().exercisesForMuscleGroup(MuscleGroups.shoulders);
  }

  @override
  void initState() {
    updateAllExercises();
    muscleGroupController = TextEditingController();
    exerciseController = TextEditingController();
    repsControllers = List.generate(
      1,
      (index) => TextEditingController(),
    );

    weightControllers = List.generate(1, (index) => TextEditingController());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> muscleGroups = MuscleGroups.muscleGroups;

    List<DropdownMenuEntry<String>> getExercisesForMuscleGroup() {
      String muscleGroup = muscleGroupController.text;

      switch (muscleGroup) {
        case 'chest':
          return chestExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'lats':
          return latsExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'abdominals':
          return absExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'shoulders':
          return absExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'triceps':
          return tricepsExercises
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'hamstrings':
          return hamstringsExercises
              .map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'biceps':
          return bicepsExercises.map<DropdownMenuEntry<String>>((String value) {
            return DropdownMenuEntry(
              label: value,
              value: value,
            );
          }).toList();
        case 'calves':
          return calvesExercises.map<DropdownMenuEntry<String>>((String value) {
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

    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8.0),
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: const Text(
                Titles.exercisePickerTitle,
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
            LayoutBuilder(
              builder: (context, constraints) {
                return SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 5),
                        padding: const EdgeInsets.all(8.0),
                        child: DropdownMenu(
                            textStyle: const TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold),
                            width: constraints.maxWidth * 0.75,
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
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(8.0),
                          child: muscleGroupController.text == ''
                              ? null
                              : DropdownMenu(
                                  textStyle: const TextStyle(
                                      color: Colors.amberAccent,
                                      fontWeight: FontWeight.bold),
                                  width: constraints.maxWidth * 0.75,
                                  controller: exerciseController,
                                  inputDecorationTheme:
                                      const InputDecorationTheme(
                                    border: InputBorder.none,
                                  ),
                                  menuStyle: MenuStyle(
                                      padding:
                                          MaterialStateProperty.all<EdgeInsets>(
                                              const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 20))),
                                  label: const Text(DropdownTitles.exercise),
                                  onSelected: (value) {
                                    setState(() {
                                      weightControllers[0].clear();
                                      repsControllers[0].clear();
                                      exerciseController.text =
                                          value.toString();
                                    });
                                  },
                                  // width: MediaQuery.of(context).size.width * 0.75,
                                  dropdownMenuEntries:
                                      getExercisesForMuscleGroup()),
                        ),
                      ),
                      SingleChildScrollView(
                        child: Opacity(
                            opacity: exerciseController.text == '' ? 0 : 1,
                            child: SizedBox(
                              height: 200,
                              width: constraints.maxWidth * 0.9,
                              child: ListView.builder(
                                itemCount: setsCount,
                                itemBuilder: (context, index) {
                                  return SizedBox(
                                    child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            width: 100,
                                            child: TextField(
                                              maxLines: 1,
                                              maxLength: 3,
                                              enableSuggestions: false,
                                              controller:
                                                  repsControllers[index],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                helperStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
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
                                            width: 120,
                                            child: TextField(
                                              maxLines: 1,
                                              maxLength: 5,
                                              enableSuggestions: false,
                                              controller:
                                                  weightControllers[index],
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: const InputDecoration(
                                                counterText: '',
                                                helperStyle: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 14),
                                                helperText:
                                                    DropdownTitles.weight,
                                                suffixIcon: Icon(
                                                  Icons.monitor_weight_outlined,
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
                            )),
                      )
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
                    // if (widget.existingExercise != null) {
                    //   Provider.of<ExercisePickerProvider>(context, listen: false)
                    //       .updateExercise(
                    //     Exercise(
                    //         name: exerciseController.text,
                    //         muscleGroup: muscleGroupController.text,
                    //         isExerciseDone: false,
                    //         sets: [
                    //           for (int i = 0; i < setsCount; i++)
                    //             WorkoutSet(
                    //                 reps: int.tryParse(repsControllers[i].text) ??
                    //                     0,
                    //                 weight: double.tryParse(
                    //                         weightControllers[i].text) ??
                    //                     0,
                    //                 isDone: false)
                    //         ]),
                    //   );
                    //   Navigator.pop(context);

                    Provider.of<LiveWorkoutProvider>(context, listen: false)
                        .addExerciseToWorkout(ExerciseModel(
                            exercise: exerciseController.text,
                            muscleGroup: muscleGroupController.text,
                            sets: [
                          for (int i = 0; i < setsCount; i++)
                            WorkoutSet(
                                reps:
                                    int.tryParse(repsControllers[i].text) ?? 0,
                                weight: double.tryParse(
                                        weightControllers[i].text) ??
                                    0,
                                isDone: false)
                        ]));
                    Navigator.pop(context);
                  }
                })
          ]),
    );
  }
}
