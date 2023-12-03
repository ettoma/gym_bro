import 'dart:ui';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/widgets/quick_workout_exercise_picker.dart';
import 'package:gym_bro/widgets/workout_exercise_tile.dart';
import 'package:provider/provider.dart';

import '../global/colours.dart';
import '../global/quick_workout_exercise_picker_provider.dart';
import '../widgets/app_bar.dart';

class QuickWorkout extends StatefulWidget {
  const QuickWorkout({super.key});

  @override
  State<QuickWorkout> createState() => _QuickStartPageState();
}

class _QuickStartPageState extends State<QuickWorkout>
    with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: const Duration(),
      end: const Duration(hours: 24),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.seconds);

  @override
  Widget build(BuildContext context) {
    Brightness brigthness = MediaQuery.of(context).platformBrightness;
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.quickWorkout,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            alignment: Alignment.center,
            child: CustomTimer(
              controller: _controller,
              builder: (state, time) {
                return Text("${time.hours}:${time.minutes}:${time.seconds}",
                    style: const TextStyle(
                        fontSize: 36.0, fontWeight: FontWeight.bold));
              },
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: const Icon(Icons.play_arrow_rounded),
              onPressed: () {
                _controller.start();
              },
            ),
            IconButton(
              icon: const Icon(Icons.pause_rounded),
              onPressed: () {
                _controller.pause();
              },
            ),
            IconButton(
              icon: const Icon(Icons.stop_rounded),
              onPressed: () {
                _controller.reset();
              },
            ),
          ],
        ),
        Consumer<QuickWorkoutExercisePickerProvider>(
            builder: (context, exercisePickerProvider, _) {
          List<Exercise> exercisesFromProvider =
              exercisePickerProvider.getExercises;
          return Expanded(
            child: ListView.builder(
              clipBehavior: Clip.antiAlias,
              itemCount: exercisesFromProvider.length,
              itemBuilder: (context, index) {
                return Container(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: WorkoutExerciseTile(
                    exercise: exercisesFromProvider[index],
                    exerciseIndex: index,
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
      ]),
      floatingActionButton: FloatingActionButton(
          backgroundColor: brigthness == Brightness.dark
              ? ColorPalette.darkBox
              : ColorPalette.lightBox,
          foregroundColor: brigthness == Brightness.dark
              ? ColorPalette.lightText
              : ColorPalette.darkText,
          elevation: 1,
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                context: (context),
                builder: (context) {
                  return SizedBox(
                      height: deviceSize.height * 0.9,
                      child: const QuickWorkoutExercisePicker());
                });
          }),
    );
  }
}
