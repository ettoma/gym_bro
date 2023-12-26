import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';
import 'package:provider/provider.dart';

import '../global/exercise_picker_provider.dart';
import '../global/quick_workout_exercise_picker_provider.dart';

class NavBar extends StatelessWidget implements PreferredSizeWidget {
  String pageTitle;
  bool implyLeading;
  bool blockBackButton;

  NavBar(
      {super.key,
      this.pageTitle = 'Gym bro',
      this.blockBackButton = false,
      this.implyLeading = true});

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(pageTitle),
      automaticallyImplyLeading: true,
      leading: blockBackButton == false
          ? null
          : IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () => showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      title: const Text(Titles.cancelQuickWorkout),
                      contentPadding: const EdgeInsets.all(20),
                      titleTextStyle: const TextStyle(fontSize: 18),
                      actions: [
                        TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              'No',
                              style: TextStyle(color: Colors.amberAccent),
                            )),
                        TextButton(
                            onPressed: () {
                              if (pageTitle == 'workout builder') {
                                Provider.of<ExercisePickerProvider>(context,
                                        listen: false)
                                    .emptyList();
                              } else if (pageTitle == 'quick start') {
                                Provider.of<QuickWorkoutExercisePickerProvider>(
                                        context,
                                        listen: false)
                                    .emptyList();
                              }

                              Navigator.pop(context);
                              Navigator.pop(context);
                            },
                            child: const Text('Yes')),
                      ],
                    );
                  }),
            ),
    );
  }
}
