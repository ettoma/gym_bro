import 'package:flutter/material.dart';

class LocaleProvider extends ChangeNotifier {
  String locale = 'en';
  String unitMeasure = 'metric';

  get getLocale => locale;
  get getUnitMeasure => unitMeasure;

  set setLocale(String newLocale) {
    locale = newLocale;
    notifyListeners();
  }

  set setUnitMeasure(String newUnitMeasure) {
    unitMeasure = newUnitMeasure;
    notifyListeners();
  }
}
