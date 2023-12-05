import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class LogingProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController get getEmailController => emailController;

  TextEditingController passwordController = TextEditingController();
  TextEditingController get getPasswordController => passwordController;
  bool loginLoader = false;
  bool get getloginLoader => loginLoader;
  setloginLoader(val) {
    loginLoader = val;
    notifyListeners();
  }

  Future<void> loginProccess(context) async {
    setloginLoader(true);
    try {
      var reqBody = {
        "email": getEmailController.text,
        "password": getPasswordController.text,
      };
    } catch (e) {
      dev.log(e.toString());
    }
  }
}
