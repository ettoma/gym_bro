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
  const QuickWorkout({
    super.key,
  });

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
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _controller.start();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Brightness brigthness = MediaQuery.of(context).platformBrightness;
    Size deviceSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: NavBar(
        pageTitle: PageNames.quickWorkout,
        blockBackButton: true,
      ),
      body: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Container(
            padding:
                const EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
            alignment: Alignment.center,
            child: CustomTimer(
              controller: _controller,
              builder: (state, time) {
                return Text("${time.hours}:${time.minutes}:${time.seconds}",
                    style: const TextStyle(
                        fontSize: 36.0, fontWeight: FontWeight.bold));
              },
            )),
        Container(
          width: deviceSize.width * 0.4,
          margin: const EdgeInsets.only(bottom: 20),
          decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.white12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: const Icon(
                  Icons.play_arrow_rounded,
                ),
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
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text(Titles.cancelQuickWorkout),
                          contentPadding: const EdgeInsets.all(20),
                          titleTextStyle: const TextStyle(fontSize: 18),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.redAccent,
                                )),
                            IconButton(
                                onPressed: () {
                                  Provider.of<QuickWorkoutExercisePickerProvider>(
                                          context,
                                          listen: false)
                                      .emptyList();
                                  _controller.reset();
                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                },
                                icon: const Icon(
                                  Icons.check,
                                )),
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
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
                  child: Dismissible(
                    key: UniqueKey(),
                    dismissThresholds:
                        Map.from({DismissDirection.endToStart: 0.3}),
                    direction: DismissDirection.endToStart,
                    background: stackBehindDismiss(),
                    child: WorkoutExerciseTile(
                      exercise: exercisesFromProvider[index],
                      exerciseIndex: index,
                    ),
                    confirmDismiss: (direction) async {
                      showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              titleTextStyle: const TextStyle(fontSize: 18),
                              title: const Text(Titles.deleteExercise),
                              actions: [
                                IconButton(
                                    icon: const Icon(
                                      Icons.clear,
                                      color: Colors.redAccent,
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    }),
                                IconButton(
                                    icon: const Icon(
                                      Icons.check,
                                    ),
                                    onPressed: () {
                                      Provider.of<QuickWorkoutExercisePickerProvider>(
                                              context,
                                              listen: false)
                                          .deleteExercise(index);
                                      Navigator.of(context).pop();
                                    })
                              ],
                            );
                          });
                      return;
                    },
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
            showDialog(
                context: (context),
                builder: (context) {
                  return SizedBox(
                      height: deviceSize.height * 0.9,
                      child: const Dialog(child: QuickWorkoutExercisePicker()));
                });
          }),
    );
  }
}

Widget stackBehindDismiss() {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      color: Colors.redAccent,
    ),
    alignment: Alignment.centerRight,
    padding: const EdgeInsets.only(right: 20.0),
    child: const Icon(
      Icons.delete,
      color: Colors.white,
    ),
  );
}
