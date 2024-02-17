import 'package:flutter/material.dart';

import '../database/data_model.dart';

class LiveWorkoutProvider extends ChangeNotifier {
  WorkoutModel? workout;

  void setWorkout(WorkoutModel w) {
    workout = w.copyWith();
    notifyListeners();
  }

  void addExerciseToWorkout(ExerciseModel e) {
    if (workout != null) {
      workout!.exercises.add(e);
      notifyListeners();
    }
  }

  void addSetToExercise(WorkoutSet set, int exerciseIndex) {
    if (workout != null) {
      workout!.exercises[exerciseIndex].sets.add(set);
      notifyListeners();
    }
  }

  void clearWorkout(int originalWorkoutLength) {
    for (var e in workout!.exercises) {
      for (var s in e.sets) {
        s.isDone = false;
      }
    }
    // Check if the original workout was different from the completed workout, and restore
    // the original workout if it was different.
    // workout!.exercises
    //     .removeRange(originalWorkoutLength, workout!.exercises.length);
    // notifyListeners();
  }
}
