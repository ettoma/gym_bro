import 'package:flutter/material.dart';

import 'quick_workout_exercise_picker_provider.dart';

class ExercisePickerProvider extends ChangeNotifier {
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

  get getExercises => exercises;
}
