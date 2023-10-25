import 'package:flutter/material.dart';

class UserRegProvider extends ChangeNotifier {
  bool loadPageRefData = false;
  bool get getloadPageRefData => loadPageRefData;
  setloadPageRefData(val) {
    loadPageRefData = val;
    notifyListeners();
  }
}
