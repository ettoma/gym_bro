import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite/sqflite.dart';

import 'data_model.dart';
import 'database_provider.dart';

class DatabaseUtils {
  late Database database;

  Future<void> initialise() async {
    Future<String> getPathToDB() async {
      switch (defaultTargetPlatform) {
        case TargetPlatform.android:
          String path = await getDatabasesPath().then((path) => path);
          return path;
        case TargetPlatform.iOS:
          String path = await getLibraryDirectory().then((dir) => dir.path);
          return path;
        case TargetPlatform.macOS:
          String path = await getLibraryDirectory().then((dir) => dir.path);
          return path;
        case TargetPlatform.windows:
          String path =
              await getApplicationDocumentsDirectory().then((dir) => dir.path);
          return path;
        case TargetPlatform.fuchsia:
          String path = await getLibraryDirectory().then((dir) => dir.path);
          return path;
        case TargetPlatform.linux:
          String path = await getLibraryDirectory().then((dir) => dir.path);
          return path;

        default:
          throw UnsupportedError('Unsupported platform');
      }
    }

    await openDatabase(
      join(await getPathToDB(), 'workout_database14.db'),
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE workouts(id INTEGER PRIMARY KEY, workoutName TEXT, exercises TEXT, isFavourite BOOLEAN)',
        );
        await db.execute(
            'CREATE TABLE workoutLogs(id INTEGER PRIMARY KEY, workoutName TEXT, exercises TEXT, isFavourite BOOLEAN, completedOn TEXT, duration TEXT)');

        return;
      },
      version: 1,
    ).then((db) {
      database = db;
    });

    // Check if the workout table exists
    final List<Map<String, dynamic>> maps = await database.rawQuery(
        'SELECT name FROM sqlite_master WHERE name = ?', ['workouts']);

    // Create the workout table if it doesn't exist
    if (maps.isEmpty) {
      await database.rawQuery(
          'CREATE TABLE workouts(id INTEGER PRIMARY KEY, workoutName TEXT, exercises TEXT, isFavourite BOOLEAN)');
    }
  }

  Future<void> initialiseProviderDatabase(context) async {
    List<WorkoutModel> workouts = await getAllWorkouts();

    for (var w in workouts) {
      Provider.of<DatabaseProvider>(context, listen: false).addWorkoutToList(w);
    }

    List<CompletedWorkoutModel> completedWorkouts =
        await getCompletedWorkouts();

    for (var w in completedWorkouts) {
      Provider.of<DatabaseProvider>(context, listen: false)
          .addCompletedWorkoutToList(w);
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

  Future<void> insertWorkout(WorkoutModel workout) async {
    await initialise();

    List<String> exercisesList = [];

    for (var e in workout.exercises) {
      exercisesList.add(
        '{"name":"${e.exercise}","muscleGroup":"${e.muscleGroup}","sets":${e.sets.map((set) => '{"reps":${set.reps},"weight":${set.weight},"isDone":${set.isDone}}').toList().toString()}}',
      );
    }

    database.rawQuery('INSERT INTO workouts VALUES (?,?,?,?)', [
      workout.id,
      workout.name,
      exercisesList.toString(),
      'false',
    ]);
  }

  Future<void> updateExistingWorkout(
      int existingWorkoutId, WorkoutModel newWorkout) async {
    await initialise();

    List<String> exercisesList = [];

    for (var e in newWorkout.exercises) {
      exercisesList.add(
        '{"name":"${e.exercise}","muscleGroup":"${e.muscleGroup}","sets":${e.sets.map((set) => '{"reps":${set.reps},"weight":${set.weight},"isDone":${set.isDone}}').toList().toString()}}',
      );
    }

    database.rawQuery(
        'UPDATE workouts SET workoutName = ?, exercises = ?, isFavourite = ? WHERE id = ?',
        [
          newWorkout.name,
          exercisesList.toString(),
          "false",
          existingWorkoutId
        ]);
  }

  Future<List<WorkoutModel>> getAllWorkouts() async {
    await initialise();
    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT * FROM workouts');

    List<WorkoutModel> workoutList = [];
    for (var w in maps) {
      List<ExerciseModel> exercisesList = [];

      jsonDecode(w['exercises']).forEach((exercise) {
        List<WorkoutSet> setsList = [];
        exercise['sets'].forEach((set) {
          setsList.add(WorkoutSet(
              reps: set['reps'], weight: set['weight'], isDone: set['isDone']));
        });

        exercisesList.add(ExerciseModel(
          id: 0,
          muscleGroup: exercise['muscleGroup'],
          exercise: exercise['name'],
          sets: setsList,
        ));
      });
      workoutList.add(
        WorkoutModel(
            id: w['id'],
            name: w['workoutName'],
            exercises: exercisesList,
            isFavourite: bool.parse(w['isFavourite'])),
      );
    }

    return workoutList;

    /*
    {id: 472026, 
    workoutName: push day, 
    exercises: [{"name":"bench press","muscleGroup":"chest","sets":[{"reps":10,"weight":20.0,"isDone":false}, 
        {"reps":15,"weight":20.0,"isDone":false}]}], 
    isFavourite: false}
    */
  }

  Future<void> getWorkoutFromName(String workoutName) async {}

  Future<void> getFavouriteWorkouts() async {}

  Future<void> getExercises() async {
    await initialise();
    final List<Map<String, dynamic>> maps = await database.query('workout');

    maps.map((map) {
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

  Future<void> deleteAllWorkouts() async {
    await initialise();

    database.rawQuery('DELETE FROM workouts');
  }

  Future<void> deleteWorkout(WorkoutModel workout) async {
    await initialise();
    database.rawQuery('DELETE FROM workouts WHERE id = ?', [workout.id]);
  }

  Future<void> saveCompletedWorkout(
      WorkoutModel workout, String duration) async {
    await initialise();

    List<String> exercisesList = [];

    for (var e in workout.exercises) {
      exercisesList.add(
        '{"name":"${e.exercise}","muscleGroup":"${e.muscleGroup}","sets":${e.sets.map((set) => '{"reps":${set.reps},"weight":${set.weight},"isDone":${set.isDone}}').toList().toString()}}',
      );
    }

    int newWorkoutId = await getCompletedWorkouts()
        .then((value) => value.isEmpty ? 1 : value[value.length - 1].id + 1);

    database.rawQuery('INSERT INTO workoutLogs VALUES (?,?,?,?,?,?)', [
      newWorkoutId,
      workout.name,
      exercisesList.toString(),
      'false',
      DateTime.now().toUtc().toString(),
      duration,
    ]);
  }

  Future<void> deleteAllCompletedWorkouts() async {
    await initialise();

    database.rawQuery('DELETE FROM workoutLogs');
  }

  Future<List<CompletedWorkoutModel>> getCompletedWorkouts() async {
    await initialise();

    final List<Map<String, dynamic>> maps =
        await database.rawQuery('SELECT * FROM workoutLogs');

    List<CompletedWorkoutModel> workoutList = [];
    for (var w in maps) {
      List<ExerciseModel> exercisesList = [];

      jsonDecode(w['exercises']).forEach((exercise) {
        List<WorkoutSet> setsList = [];
        exercise['sets'].forEach((set) {
          setsList.add(WorkoutSet(
              reps: set['reps'], weight: set['weight'], isDone: set['isDone']));
        });

        exercisesList.add(ExerciseModel(
          id: 0,
          muscleGroup: exercise['muscleGroup'],
          exercise: exercise['name'],
          sets: setsList,
        ));
      });
      workoutList.add(
        CompletedWorkoutModel(
            id: w['id'],
            name: w['workoutName'],
            exercises: exercisesList,
            isFavourite: bool.parse(w['isFavourite']),
            completedOn: w['completedOn'],
            duration: w['duration']),
      );
    }
    return workoutList;
  }
}
