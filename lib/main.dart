import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gym_bro/database/database_provider.dart';
import 'package:gym_bro/database/database_utils.dart';
import 'package:gym_bro/global/live_workout_provider.dart';
import 'package:gym_bro/global/locale_provider.dart';
import 'package:gym_bro/global/navigator_observer.dart';
import 'package:provider/provider.dart';

import 'global/exercise_picker_provider.dart';
import 'global/quick_workout_exercise_picker_provider.dart';
import 'global/theme_provider.dart';
import 'views/home.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  GoogleFonts.config.allowRuntimeFetching = true;

  await DatabaseUtils().initialise();

  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => LocaleProvider()),
    ChangeNotifierProvider(create: (context) => DatabaseProvider()),
    ChangeNotifierProvider(
      create: (context) => ExercisePickerProvider(),
    ),
    ChangeNotifierProvider(
        create: (context) => QuickWorkoutExercisePickerProvider()),
    ChangeNotifierProvider(create: (context) => LiveWorkoutProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorObservers: [PageNavigationObserver()],
      debugShowCheckedModeBanner: false,
      title: 'Gym Bro',
      darkTheme: ThemeProvider().darkMode,
      theme: ThemeProvider().darkMode, //! fix light mode eventually
      home: const Home(),
    );
  }
}
