/*
      name workout | id | exercises | isFavourite
                           ----> exercise: name, muscleGroup, sets
                                                              ----> reps | weight | isDone

      {
        "id": 1,
        "workoutName": "push day",
        "exercises": [
          {
            "name": "chest press",
            "muscleGroup": "chest",
            "sets": [
              {
                "reps": 10,
                "weight": 20.0,
                "isDone": false
              }
            ]
          }
        ]
        "isFavourite": true
      }

      
    */

class ExerciseModel {
  int id;
  String muscleGroup;
  String exercise;
  List<WorkoutSet> sets;

  ExerciseModel(
      {this.id = 0,
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

  factory ExerciseModel.fromMap(Map<String, dynamic> map) {
    return ExerciseModel(
      id: map['id'],
      muscleGroup: map['muscleGroup'],
      exercise: map['exercise'],
      sets:
          List<WorkoutSet>.from(map['sets']?.map((x) => WorkoutSet.fromMap(x))),
    );
  }
}

class CompletedWorkoutModel {
  int id;
  String name;
  List<ExerciseModel> exercises;
  bool isFavourite;
  String completedOn;
  String duration;

  CompletedWorkoutModel(
      {required this.id,
      required this.name,
      required this.exercises,
      required this.isFavourite,
      required this.completedOn,
      required this.duration});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
      'isFavourite': isFavourite,
      'completedOn': completedOn,
    };
  }

  factory CompletedWorkoutModel.fromMap(Map<String, dynamic> map) {
    return CompletedWorkoutModel(
        id: map['id'],
        name: map['workoutName'],
        exercises: List<ExerciseModel>.from(
            map['exercises']?.map((x) => ExerciseModel.fromMap(x))),
        isFavourite: map['isFavourite'],
        completedOn: map['completedOn'],
        duration: map['duration']);
  }
}

class WorkoutModel {
  int id;
  String name;
  List<ExerciseModel> exercises;
  bool isFavourite;

  WorkoutModel(
      {required this.id,
      required this.name,
      required this.exercises,
      required this.isFavourite});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'exercises': exercises.map((exercise) => exercise.toMap()).toList(),
      'isFavourite': isFavourite,
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'],
      name: map['workoutName'],
      exercises: List<ExerciseModel>.from(
          map['exercises']?.map((x) => ExerciseModel.fromMap(x))),
      isFavourite: map['isFavourite'],
    );
  }

  WorkoutModel copyWith(
      {int? id,
      String? name,
      List<ExerciseModel>? exercises,
      bool? isFavourite}) {
    return WorkoutModel(
      id: id ?? this.id,
      name: name ?? this.name,
      exercises: exercises ?? this.exercises,
      isFavourite: isFavourite ?? this.isFavourite,
    );
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

  factory WorkoutSet.fromMap(Map<String, dynamic> map) {
    return WorkoutSet(
      reps: map['reps'],
      weight: map['weight'],
      isDone: map['isDone'],
    );
  }
}
