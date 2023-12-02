import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gym_bro/global/exercise_picker_provider.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/exercise_picker.dart';
import 'package:gym_bro/widgets/exercise_tile.dart';
import 'package:provider/provider.dart';

import '../global/colours.dart';
import '../global/text.dart';

class WorkoutBuilder extends StatefulWidget {
  const WorkoutBuilder({super.key});

  @override
  State<WorkoutBuilder> createState() => _WorkoutBuilderState();
}

class _WorkoutBuilderState extends State<WorkoutBuilder> {
  TextEditingController workoutTitleController = TextEditingController();

  List<ExerciseTile> exerciseList = [];

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.workoutBuilder,
      ),
      body: Column(
        children: [
          TextField(
            autofocus: workoutTitleController.text.isEmpty ? true : false,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .copyWith(fontSize: 30, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(25),
                hintText: HelperText.workoutTitle,
                hintStyle: TextStyle(fontSize: 16)),
            controller: workoutTitleController,
          ),
          Consumer<ExercisePickerProvider>(
              builder: (context, exercisePickerProvider, _) {
            List<Map<String, dynamic>> exercisesFromProvider =
                exercisePickerProvider.getExercises;
            return Expanded(
              child: ListView.builder(
                clipBehavior: Clip.antiAlias,
                itemCount: exercisesFromProvider.length,
                itemBuilder: (context, index) {
                  return Container(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: ExerciseTile(
                      exercises: exercisesFromProvider[index],
                    ),
                  );
                },
              ),
            );
          }),
          SizedBox(
            height: 80,
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(
                    sigmaX: 10, sigmaY: 10, tileMode: TileMode.clamp),
                child: Container(
                  color: Colors.transparent,
                ),
              ),
            ),
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          backgroundColor: brigthness == Brightness.dark
              ? ColorPalette.darkBox
              : ColorPalette.lightBox,
          foregroundColor: brigthness == Brightness.dark
              ? ColorPalette.lightText
              : ColorPalette.darkText,
          elevation: 1,
          child: Icon(Icons.add,
              color: brigthness == Brightness.dark
                  ? ColorPalette.darkText
                  : ColorPalette.lightText),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: (context),
                builder: (context) {
                  return SizedBox(
                      height: deviceSize.height * 0.9,
                      child: const ExercisePicker());
                });
          }),
    );
  }
}
