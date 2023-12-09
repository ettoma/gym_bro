import 'dart:convert';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'data_model.dart';

class DatabaseUtils {
  late Database database;

  Future<void> initialise() async {
    //!! IMPORTANT !!
    //!! for iOS , implement getLibraryDirectory()
    await openDatabase(
      join(await getDatabasesPath(), 'workout_database7.db'),
      onCreate: (db, version) async {
        return await db.execute(
          'CREATE TABLE workout(id INTEGER PRIMARY KEY, exercise TEXT, muscleGroup TEXT, sets TEXT)',
        );
      },
      version: 1,
    ).then((db) {
      database = db;
    });

    final List<Map<String, dynamic>> maps = await database
        .rawQuery('SELECT name FROM sqlite_master WHERE name = ?', ['workout']);

    // Create the workout table if it doesn't exist
    if (maps.isEmpty) {
      await database.rawQuery(
          'CREATE TABLE workout(id INTEGER PRIMARY KEY, exercise TEXT, muscleGroup TEXT, sets TEXT)');
    }
  }

  Future<void> insertExercise(ExerciseModel exercise) async {
    await initialise();

    database.rawQuery('INSERT INTO workout VALUES (?,?,?,?)', [
      exercise.id,
      exercise.exercise,
      exercise.muscleGroup,
      exercise.sets
          .map((set) =>
              '{"reps":${set.reps},"weight":${set.weight},"isDone":${set.isDone}}')
          .toList()
          .toString(),
    ]);
  }

  Future<void> getExercises() async {
    await initialise();
    final List<Map<String, dynamic>> maps = await database.query('workout');

    final List<ExerciseModel> exercises = maps.map((map) {
      List<WorkoutSet> sets = [];

      jsonDecode(map['sets']).forEach((set) {
        sets.add(WorkoutSet(
          reps: set['reps'],
          weight: set['weight'],
          isDone: set['isDone'],
        ));
      });

      ExerciseModel exercise = ExerciseModel(
        id: map['id'],
        muscleGroup: map['muscleGroup'],
        exercise: map['exercise'],
        sets: sets,
      );

      return exercise;
    }).toList();
  }

  DatabaseUtils();
}
