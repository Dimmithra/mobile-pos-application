import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';

class HomeProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  void clearAllData() async {
    await storage.deleteAll();
  }

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  bool homePageLoader = false;
  bool get gethomePageLoader => homePageLoader;
  sethomePageLoader(val) {
    homePageLoader = val;
    notifyListeners();
  }
}
