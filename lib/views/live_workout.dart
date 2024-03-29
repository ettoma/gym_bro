import 'dart:ui';

import 'package:custom_timer/custom_timer.dart';
import 'package:flutter/material.dart';
import 'package:gym_bro/database/data_model.dart';
import 'package:gym_bro/database/database_provider.dart';
import 'package:gym_bro/global/live_workout_provider.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/views/home.dart';
import 'package:gym_bro/widgets/live_workout_exercise_picker.dart';
import 'package:provider/provider.dart';

import '../database/database_utils.dart';
import '../global/colours.dart';
import '../widgets/app_bar.dart';
import '../widgets/live_workout_exercise_tile.dart';

class LiveWorkout extends StatefulWidget {
  WorkoutModel workout;
  int workoutExerciseListLength;
  LiveWorkout(
      {super.key,
      required this.workout,
      required this.workoutExerciseListLength});

  @override
  State<LiveWorkout> createState() => _LiveWorkoutPageState();
}

class _LiveWorkoutPageState extends State<LiveWorkout>
    with SingleTickerProviderStateMixin {
  late final CustomTimerController _controller = CustomTimerController(
      vsync: this,
      begin: const Duration(),
      end: const Duration(hours: 24),
      initialState: CustomTimerState.reset,
      interval: CustomTimerInterval.seconds);

  DateTime _initialTime = DateTime.now();
  DateTime _endTime = DateTime.now();

  // @override
  // void didChangeDependencies() {
  //   Provider.of<LiveWorkoutProvider>(context, listen: false)
  //       .setWorkout(widget.workout);
  //   super.didChangeDependencies();
  // }

  @override
  void initState() {
    super.initState();
    _initialTime = DateTime.now();
    _controller.start();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  String getWorkoutDuration() {
    _endTime = DateTime.now();
    Duration duration = _endTime.difference(_initialTime);
    return duration.inSeconds.toString();
  }

  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    Brightness brigthness = MediaQuery.of(context).platformBrightness;

    return Scaffold(
      appBar: NavBar(
        pageTitle: widget.workout.name,
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
                    style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color:
                            _controller.state.value == CustomTimerState.paused
                                ? Colors.white24
                                : Colors.white));
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
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
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
                  icon: const Icon(
                    Icons.stop_rounded,
                    color: Colors.redAccent,
                  ),
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
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.redAccent,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.check,
                              ),
                              onPressed: () {
                                _controller.reset();
                                if (widget.workout.exercises.isEmpty) {
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                } else {
                                  DatabaseUtils().saveCompletedWorkout(
                                      widget.workout, getWorkoutDuration());
                                  Provider.of<DatabaseProvider>(context,
                                          listen: false)
                                      .addCompletedWorkoutToList(
                                          CompletedWorkoutModel(
                                              id: 1,
                                              name: widget.workout.name,
                                              exercises:
                                                  widget.workout.exercises,
                                              isFavourite: false,
                                              completedOn: DateTime.now()
                                                  .toUtc()
                                                  .toString(),
                                              duration: getWorkoutDuration()));
                                  Provider.of<LiveWorkoutProvider>(context,
                                          listen: false)
                                      .clearWorkout(
                                          widget.workoutExerciseListLength);
                                  Navigator.of(context).pop();
                                  Navigator.of(context).pop();
                                }
                              },
                            ),
                          ],
                        );
                      },
                    );
                  })
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<LiveWorkoutProvider>(
              builder: (context, workoutProvider, _) {
            return ListView.builder(
                clipBehavior: Clip.antiAlias,
                itemCount: workoutProvider.workout!.exercises.length,
                itemBuilder: (context, index) {
                  return Container(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Dismissible(
                          key: UniqueKey(),
                          direction: DismissDirection.endToStart,
                          background: stackBehindDismiss(),
                          child: LiveWorkoutExerciseTile(
                            exercise: workoutProvider.workout!.exercises[index],
                            exerciseIndex: index,
                          ),
                          confirmDismiss: (direction) async {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    titleTextStyle:
                                        const TextStyle(fontSize: 18),
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
                                            Provider.of<LiveWorkoutProvider>(
                                                    context,
                                                    listen: false)
                                                .deleteExercise(index);
                                            Navigator.of(context).pop();
                                          })
                                    ],
                                  );
                                });
                            return;
                          }));
                });
          }),
        )),
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
              ? Colors.blueAccent
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
                context: context,
                builder: (context) {
                  return Dialog(child: LiveWorkoutExercisePicker());
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
