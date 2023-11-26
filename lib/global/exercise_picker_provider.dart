import 'package:flutter/material.dart';

class ExercisePickerProvider extends ChangeNotifier {
  Map<String, dynamic> exercise = {};

  void setExercise(exercise) {
    print(exercise);
    notifyListeners();
  }

  get getExercise => exercise;
}
