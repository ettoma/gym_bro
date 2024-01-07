import 'package:gym_bro/exercises/exercises_helper.dart';

class ExerciseList {
  Future<List<String>> exercisesForMuscleGroup(String muscleGroup) async {
    List<String> exercises = [];

    List<ExerciseFromJson> exerciseList =
        await ExercisesHelper().getExercises();

    for (var ex in exerciseList) {
      if (ex.primaryMuscles.contains(muscleGroup)) {
        exercises.add(ex.name);
      }
    }

    return exercises;
  }
}

class MuscleGroups {
  static const String chest = 'chest';
  static const String lats = 'lats';
  static const String abs = 'abdominals';
  static const String biceps = 'biceps';
  static const String hamstrings = 'hamstrings';
  static const String triceps = 'triceps';
  static const String shoulders = 'shoulders';
  static const String arms = 'arms';
  static const String core = 'core';

  static const List<String> muscleGroups = [
    chest,
    abs,
    triceps,
    lats,
    hamstrings,
    shoulders,
    arms,
    core,
    biceps,
  ];
}
