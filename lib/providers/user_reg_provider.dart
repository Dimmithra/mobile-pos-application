import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:mobile_pos/utils/url.dart';

class UserRegProvider extends ChangeNotifier {
  bool loadPageRefData = false;
  bool get getloadPageRefData => loadPageRefData;
  setloadPageRefData(val) {
    loadPageRefData = val;
    notifyListeners();
  }

  bool loadSaveData = false;
  bool get getloadSaveData => loadSaveData;
  setloadSaveData(val) {
    loadSaveData = val;
    notifyListeners();
  }

  Future<void> saveUserDetails(context) async {
    setloadSaveData(true);
    try {
      var reqBody = {
        "customername": "22",
        "mobileno": "015",
        "address": "54",
        "email": "545",
        "password": "54",
        "deviceid": "54",
        "location": "54",
        "logtime": "54"
      };
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kuserregistration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      dev.log(response.body);
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadSaveData(false);
    }
  }
}
