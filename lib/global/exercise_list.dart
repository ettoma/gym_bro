import 'package:gym_bro/exercises/exercises_helper.dart';

class ExerciseList {
  Future<List<String>> chestExercises() async {
    List<String> chestExercise = [];

    List<ExerciseFromJson> exerciseList =
        await ExercisesHelper().getExercises();

    for (var ex in exerciseList) {
      if (ex.primaryMuscles.contains("chest")) {
        chestExercise.add(ex.name);
      }
    }

    return chestExercise;
  }

  Future<List<String>> latsExercises() async {
    List<String> latsExercise = [];

    List<ExerciseFromJson> exerciseList =
        await ExercisesHelper().getExercises();

    for (var ex in exerciseList) {
      if (ex.primaryMuscles.contains("lats")) {
        latsExercise.add(ex.name);
      }
    }

    return latsExercise;
  }
}

class MuscleGroups {
  static const String chest = 'chest';
  static const String lats = 'lats';
  static const String legs = 'legs';
  static const String shoulders = 'shoulders';
  static const String arms = 'arms';
  static const String core = 'core';

  static const List<String> muscleGroups = [
    chest,
    lats,
    legs,
    shoulders,
    arms,
    core
  ];
}
