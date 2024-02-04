import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_model.dart';

class DatabaseProvider extends ChangeNotifier {
  List<WorkoutModel> workoutList = [];
  List<CompletedWorkoutModel> completedWorkoutList = [];

  void addWorkoutToList(WorkoutModel workout) {
    workoutList.add(workout);
    notifyListeners();
  }

  void updateWorkoutList(WorkoutModel workout) {
    for (var w in workoutList) {
      if (w.id == workout.id) {
        workoutList[workoutList.indexOf(w)] = workout;
      }
    }

    notifyListeners();
  }

  WorkoutModel? getWorkoutById(int workoutId) {
    for (var w in workoutList) {
      if (w.id == workoutId) {
        return w;
      }
    }
    return null;
  }

  CompletedWorkoutModel? getCompletedWorkoutById(int workoutId) {
    for (var w in completedWorkoutList) {
      if (w.id == workoutId) {
        return w;
      }
    }
    return null;
  }

  void deleteAllWorkouts() {
    workoutList.clear();
    notifyListeners();
  }

  void deleteWorkout(WorkoutModel workout) {
    workoutList.remove(workout);
    notifyListeners();
  }

  void deleteAllCompletedWorkouts() {
    completedWorkoutList.clear();
    notifyListeners();
  }

  void addCompletedWorkoutToList(CompletedWorkoutModel workout) {
    completedWorkoutList.insert(0, workout);
    notifyListeners();
  }
}
