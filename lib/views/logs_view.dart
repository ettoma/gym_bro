import 'package:flutter/material.dart';
import 'package:gym_bro/global/text.dart';
import 'package:gym_bro/widgets/app_bar.dart';
import 'package:gym_bro/widgets/completed_workout_dialog.dart';
import 'package:gym_bro/widgets/logs_workout_tile.dart';
import 'package:provider/provider.dart';

import '../database/database_provider.dart';

class LogsPage extends StatefulWidget {
  const LogsPage({super.key});

  @override
  State<LogsPage> createState() => _LogsPageState();
}

class _LogsPageState extends State<LogsPage> {
  @override
  Widget build(BuildContext context) {
    Size deviceSize = MediaQuery.of(context).size;
    return Scaffold(
        appBar: NavBar(
          pageTitle: PageNames.logs,
        ),
        body:
            Consumer<DatabaseProvider>(builder: (context, databaseProvider, _) {
          return ListView.builder(
              itemCount: databaseProvider.completedWorkoutList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onLongPress: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return CompletedWorkoutDialog(
                            deviceSize: deviceSize,
                            workout:
                                databaseProvider.completedWorkoutList[index],
                          );
                        });
                  },
                  child: LogsWorkoutTile(
                    workout: databaseProvider.completedWorkoutList[index],
                  ),
                );
              });
        }));
  }
}
