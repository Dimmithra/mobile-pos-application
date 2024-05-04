import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_pos/model/login_model.dart';
import 'package:mobile_pos/screens/main_home/dashboard/dashboard.dart';
import 'package:mobile_pos/services/common_http.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'package:mobile_pos/utils/message.dart';
import 'dart:developer' as dev;

import 'package:mobile_pos/utils/url.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class LogingProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

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

  bool loadingLoginData = false;
  bool get getloadingLoginData => loadingLoginData;
  setloadingLoginData(val) {
    loadingLoginData = val;
    notifyListeners();
  }

  clearLoginData() async {
    getEmailController.clear();
    getPasswordController.clear();
  }

  Future<void> loginProccess(context) async {
    setloadingLoginData(true);
    try {
      final CommonHttp commonHttp = CommonHttp('', '');
      final data = {
        "email": emailController.text,
        "password": passwordController.text,
      };
      dev.log("$data");
      final response = await commonHttp.post(klogin, data);
      dev.log("$response");
      LoginModal temp = LoginModal.fromJson(jsonDecode(response));
      if (temp.success == "success") {
        commonMessage(context,
            errorTxt: "${temp.message}",
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text('OK'),
                onPressed: () async {
                  await storage.write(key: kEmail, value: emailController.text);
                  await storage.write(
                      key: kPassword, value: passwordController.text);
                  await storage.write(key: kValidateUserData, value: 'true');
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Dashbaord(),
                    ),
                    (route) => false,
                  );
                },
              )
            ]).show();
      } else {
        commonMessage(
          context,
          errorTxt: temp.message.toString(),
          btnType: 1,
        ).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadingLoginData(false);
    }
  }

  LoginModal? loginModal;
  LoginModal? get getloginModal => loginModal;
  setloginModal(val) {
    loginModal = val;
    notifyListeners();
  }
}
