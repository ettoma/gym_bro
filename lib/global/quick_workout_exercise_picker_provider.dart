import 'package:flutter/material.dart';

class QuickWorkoutExercisePickerProvider extends ChangeNotifier {
  List<Exercise> exercises = [];

  void setExercise(Exercise exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  void setIsDone(int exerciseIndex, int setIndex, bool value) {
    exercises[exerciseIndex].sets[setIndex].isDone = value;
    notifyListeners();
  }

  void emptyList() {
    exercises = [];
    notifyListeners();
  }

  void deleteExercise(int exerciseIndex) {
    exercises.removeAt(exerciseIndex);
    notifyListeners();
  }

  get getExercises => exercises;
}

class Exercise {
  String name;
  String muscleGroup;
  bool isExerciseDone;
  List<WorkoutSet> sets;
  Exercise(
      {required this.name,
      required this.muscleGroup,
      required this.isExerciseDone,
      required this.sets});

  // {
  //   name: "bench press",
  //   muscleGroup: "chest",
  //   isDone: false,
  //   sets: [
  //     {weigth: 10, reps: 10, isDone: false},
  //     {weigth: 20, reps: 10, isDone: false},
  //     {weigth: 30, reps: 10, isDone: false},
  //   ]
  // }
}

class WorkoutSet {
  int reps;
  double weight;
  bool isDone;
  WorkoutSet({required this.reps, required this.weight, required this.isDone});
}
