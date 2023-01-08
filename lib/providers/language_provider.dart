import 'package:flutter/material.dart';

import '../app/L10n.dart';


class LocaleProvider extends ChangeNotifier {

  Locale _locale = const Locale('en');

  Locale get locale => _locale;

  void setLocale(Locale locale) {
    if (!L10n.all.contains(locale)) return;
    _locale = locale;
    notifyListeners();
    print(_locale);
  }

  void clearLocale() {
    notifyListeners();
  }
}