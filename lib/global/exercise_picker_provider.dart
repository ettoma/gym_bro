import 'package:flutter/material.dart';

class ExercisePickerProvider extends ChangeNotifier {
  Map<String, dynamic> exercise = {};

  List<Map<String, dynamic>> exercises = [];

  void setExercise(exercise) {
    this.exercise = exercise;
    exercises.add(exercise);
    notifyListeners();
  }

  get getExercise => exercise;
  get getExercises => exercises;
}
