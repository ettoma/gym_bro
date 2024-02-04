import 'package:flutter/material.dart';

import '../database/data_model.dart';

class LiveWorkoutProvider extends ChangeNotifier {
  WorkoutModel? workout;

  void setWorkout(WorkoutModel w) {
    workout = w;
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

  void clearWorkout() {
    for (var e in workout!.exercises) {
      for (var s in e.sets) {
        s.isDone = false;
      }
    }
    notifyListeners();
  }
}
