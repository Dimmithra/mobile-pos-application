import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  bool homePageLoader = false;
  bool get gethomePageLoader => homePageLoader;
  sethomePageLoader(val) {
    homePageLoader = val;
    notifyListeners();
  }
}
