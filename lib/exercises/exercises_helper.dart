import 'dart:convert';

import 'package:flutter/services.dart';

class ExercisesHelper {
  Future<String> _getExercisesFromJson() async {
    final String jsonString =
        await rootBundle.loadString('lib/exercises/exercises.json');

    return jsonString;
  }

  Future<List<ExerciseFromJson>> getExercises() async {
    List<ExerciseFromJson> exercises = [];

    String jsonString = await _getExercisesFromJson();

    var data = jsonDecode(jsonString);

    for (var exercise in data) {
      var ex = ExerciseFromJson.fromJson(exercise);
      exercises.add(ex);
    }

    return exercises;
  }
}

class ExerciseFromJson {
  String id;
  String name;
  String force;
  String level;
  String mechanic;
  String equipment;
  List<String> primaryMuscles;
  List<String> secondaryMuscles;
  List<String> instructions;
  String category;
  List<String> images;

  ExerciseFromJson({
    required this.id,
    required this.name,
    required this.force,
    required this.level,
    required this.mechanic,
    required this.equipment,
    required this.primaryMuscles,
    required this.secondaryMuscles,
    required this.instructions,
    required this.category,
    required this.images,
  });

  factory ExerciseFromJson.fromJson(Map<String, dynamic> json) =>
      ExerciseFromJson(
        id: json["id"] ?? '',
        name: json["name"] ?? '',
        force: json["force"] ?? '',
        level: json["level"] ?? '',
        mechanic: json["mechanic"] ?? '',
        equipment: json["equipment"] ?? '',
        primaryMuscles: List.from(json["primaryMuscles"]),
        secondaryMuscles: List.from(json["secondaryMuscles"]),
        instructions: List.from(json["instructions"]),
        category: json["category"] ?? '',
        images: List.from(json["images"]),
      );
}
