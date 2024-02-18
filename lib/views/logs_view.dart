import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/completed_workout_dialog.dart';
import 'package:gym_bro/widgets/logs_workout_tile.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

import '../database/database_provider.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  final dateString = '2020-06-16T10:31:12.000Z';
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: NavBar(
          pageTitle: PageNames.logs,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Consumer<DatabaseProvider>(
              builder: (context, databaseProvider, _) {
            return ListView.builder(
                itemCount: databaseProvider.completedWorkoutList.length,
                itemBuilder: (context, index) {
                  bool isSameDate = true;
                  final String dateString =
                      databaseProvider.completedWorkoutList[index].completedOn;
                  final DateTime date = DateTime.parse(dateString);
                  if (index == 0) {
                    isSameDate = true;
                  } else {
                    final String prevDateString = databaseProvider
                        .completedWorkoutList[index - 1].completedOn;
                    final DateTime prevDate = DateTime.parse(prevDateString);

                    if (prevDate.month == date.month) {
                      isSameDate = true;
                    } else {
                      isSameDate = false;
                    }
                  }
                  if (index == 0 || !(isSameDate)) {
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(
                            DateFormat('MMMM').format(date),
                            style: const TextStyle(
                                color: Colors.amberAccent,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        GestureDetector(
                          onLongPress: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return CompletedWorkoutDialog(
                                    deviceSize: deviceSize,
                                    workout: databaseProvider
                                        .completedWorkoutList[index],
                                  );
                                });
                          },
                          child: LogsWorkoutTile(
                            workout:
                                databaseProvider.completedWorkoutList[index],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return GestureDetector(
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return CompletedWorkoutDialog(
                                deviceSize: deviceSize,
                                workout: databaseProvider
                                    .completedWorkoutList[index],
                              );
                            });
                      },
                      child: LogsWorkoutTile(
                        workout: databaseProvider.completedWorkoutList[index],
                      ),
                    );
                  }
                });
          }),
        ));
  }
}
