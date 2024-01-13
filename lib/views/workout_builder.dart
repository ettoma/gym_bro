import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/global/exercise_picker_provider.dart';

import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/exercise_picker.dart';
import 'package:gym_bro/widgets/exercise_tile.dart';
import 'package:provider/provider.dart';

import '../database/data_model.dart';
import '../database/database_provider.dart';
import '../global/colours.dart';
import '../global/quick_workout_exercise_picker_provider.dart' as qwep;
import '../global/text.dart';

class WorkoutBuilder extends StatefulWidget {
  String? existingWorkoutTitle;
  int? workoutId;
  WorkoutBuilder({super.key, this.existingWorkoutTitle, this.workoutId});

  @override
  State<WorkoutBuilder> createState() => _WorkoutBuilderState();
}

TextEditingController workoutTitleController = TextEditingController();

class _WorkoutBuilderState extends State<WorkoutBuilder> {
  @override
  Widget build(BuildContext context) {
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    Future<void> saveWorkout(
      List<qwep.Exercise> exercises,
      String workoutTitle,
    ) async {
      int dbSize = await DatabaseUtils().getAllWorkouts().then((e) => e.length);

      List<ExerciseModel> exerciseModels = [];

      for (var exercise in exercises) {
        exerciseModels.add(ExerciseModel(
          exercise: exercise.name,
          muscleGroup: exercise.muscleGroup,
          sets: exercise.sets
              .map((e) =>
                  WorkoutSet(reps: e.reps, weight: e.weight, isDone: e.isDone))
              .toList(),
        ));
      }

      //TODO: implement update workout DB and provider
      // if (widget.workoutId != null) {
      //   DatabaseUtils().updateWorkout(

      //   )
      // }

      DatabaseUtils().insertWorkout(
        WorkoutModel(
            id: dbSize + 1,
            name: workoutTitle,
            exercises: exerciseModels,
            isFavourite: false),
      );
      Provider.of<DatabaseProvider>(context, listen: false).addWorkoutToList(
        WorkoutModel(
            id: dbSize + 1,
            name: workoutTitle,
            exercises: exerciseModels,
            isFavourite: false),
      );
    }

    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.workoutBuilder,
        blockBackButton: true,
      ),
      body: Column(
        children: [
          TextField(
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(25),
                hintText: HelperText.workoutTitle,
                hintStyle: TextStyle(fontSize: 16)),
            controller: workoutTitleController,
          ),
          Consumer<ExercisePickerProvider>(
              builder: (context, exercisePickerProvider, _) {
            List<qwep.Exercise> exercisesFromProvider =
                exercisePickerProvider.getExercises;
            return Expanded(
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                itemCount: exercisesFromProvider.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ExerciseTile(
                      exercise: exercisesFromProvider[index],
                    ),
                  );
                },
              ),
            );
          }),
          Consumer<ExercisePickerProvider>(
            builder: (context, exercisePickerProvider, _) {
              List<qwep.Exercise> exercisesFromProvider =
                  exercisePickerProvider.getExercises;

              return TextButton(
                  child: const Text(Buttons.saveWorkout),
                  onPressed: () {
                    if (workoutTitleController.text.isEmpty ||
                        exercisesFromProvider.isEmpty) {
                      showDialog(
                          context: context,
                          builder: (context) {
                            String getErrorMessage() {
                              if (workoutTitleController.text.isEmpty) {
                                return Errors.missingWorkoutTitle;
                              } else {
                                return Errors.missingExercise;
                              }
                            }

                            return AlertDialog(
                              title: const Text(
                                Errors.error,
                                style: TextStyle(color: Colors.amberAccent),
                              ),
                              content: Padding(
                                  padding: const EdgeInsets.all(20),
                                  child: Text(getErrorMessage())),
                            );
                          });
                    } else {
                      saveWorkout(
                          exercisesFromProvider, workoutTitleController.text);
                      exercisePickerProvider.emptyList();
                      Navigator.pop(context);
                    }
                  });
            },
          ),
          SizedBox(
            height: 80,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: brigthness == Brightness.dark
              ? ColorPalette.darkBox
              : ColorPalette.lightBox,
          foregroundColor: brigthness == Brightness.dark
              ? ColorPalette.lightText
              : ColorPalette.darkText,
          elevation: 1,
          child: Icon(Icons.add,
              color: brigthness == Brightness.dark
                  ? ColorPalette.darkText
                  : ColorPalette.lightText),
          onPressed: () {
            showDialog(
                context: (context),
                builder: (context) {
                  return const Dialog(child: ExercisePicker());
                });
          }),
    );
  }
}
