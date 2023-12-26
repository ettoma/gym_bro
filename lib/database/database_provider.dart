import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_model.dart';

class DatabaseProvider extends ChangeNotifier {
  List<WorkoutModel> workoutList = [];

  void addWorkoutToList(WorkoutModel workout) {
    workoutList.add(workout);
    notifyListeners();
  }

  void deleteAllWorkouts() {
    workoutList.clear();
    notifyListeners();
  }

  void deleteWorkout(WorkoutModel workout) {
    workoutList.remove(workout);
    notifyListeners();
  }
}
