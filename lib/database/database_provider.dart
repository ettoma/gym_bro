import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider extends ChangeNotifier {
  late Database database;

  void setDatabase(database) {
    this.database = database;
    notifyListeners();
  }
}
