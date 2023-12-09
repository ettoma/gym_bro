class ExerciseModel {
  int id;
  String muscleGroup;
  String exercise;
  List<WorkoutSet> sets;

  ExerciseModel(
      {required this.id,
      required this.muscleGroup,
      required this.exercise,
      required this.sets});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'muscleGroup': muscleGroup,
      'exercise': exercise,
      'sets': sets.map((set) => set.toMap()).toList(),
    };
  }
}

class WorkoutModel {
  int id;
  String name;
  List<ExerciseModel> exercises;

  WorkoutModel({required this.id, required this.name, required this.exercises});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
    };
  }
}

class WorkoutSet {
  int reps;
  double weight;
  bool isDone;

  WorkoutSet({required this.reps, required this.weight, required this.isDone});

  Map<String, dynamic> toMap() {
    return {
      'reps': reps,
      'weight': weight,
      'isDone': isDone,
    };
  }
}
