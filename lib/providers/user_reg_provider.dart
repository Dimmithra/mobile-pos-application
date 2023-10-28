import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:mobile_pos/model/common_succ_message.dart';
import 'package:mobile_pos/screens/main_home/main_home.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/utils/url.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class UserRegProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  bool loadPageRefData = false;
  bool get getloadPageRefData => loadPageRefData;
  setloadPageRefData(val) {
    loadPageRefData = val;
    notifyListeners();
  }

  TextEditingController clientNameController = TextEditingController();
  TextEditingController get getclientNameController => clientNameController;

  TextEditingController mobileNoController = TextEditingController();
  TextEditingController get getmobileNoController => mobileNoController;

  TextEditingController addressController = TextEditingController();
  TextEditingController get getaddressController => addressController;

  TextEditingController emailController = TextEditingController();
  TextEditingController get getEmailController => emailController;

  TextEditingController passwordController = TextEditingController();
  TextEditingController get getpasswordController => passwordController;

  TextEditingController reEnterPasswordController = TextEditingController();
  TextEditingController get getreEnterPasswordController =>
      reEnterPasswordController;

  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  bool loadSaveData = false;
  bool get getloadSaveData => loadSaveData;
  setloadSaveData(val) {
    loadSaveData = val;
    notifyListeners();
  }

  Future<void> textFeildValidation(context) async {
    setloadSaveData(true);
    try {
      bool mobileNo = true;
      RegExp regExp = RegExp(r'(^(?:[+0]9)?[0-9]{10,12}$)');
      RegExp passReg = RegExp(
          r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
      if (regExp.hasMatch(mobileNoController.text)) {
        mobileNo = false;
        dev.log('Mobile Number Mismach');
      } else {
        commonMessage(context, errorTxt: 'Invalid mobile Number', btnType: 1)
            .show();
      }
      bool password = true;
      if (!mobileNo) {
        if (passwordController.text != reEnterPasswordController.text) {
          commonMessage(
            context,
            errorTxt: 'Passwords do not match',
          ).show();
        } else {
          dev.log('password match');
          password = false;
          // saveUserDetails(context);
        }
      }
      if (!password) {
        if (passReg.hasMatch(getpasswordController.text) ||
            passReg.hasMatch(getreEnterPasswordController.text)) {
          saveUserDetails(context);
        } else {
          commonMessage(context,
                  errorTxt:
                      'At least one upper case \n At least one lower case \n  At least one digit \n At least one Special character \n At least 8 characters in length')
              .show();
        }
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadSaveData(false);
    }
  }

  Future<void> saveUserDetails(context) async {
    var deviceMode = await storage.read(key: kDeviceModel);
    var googleLocation = await storage.read(key: kGoogleLocation);
    // var deviceMake = await storage.read(key: kDeviceMake);
    setloadSaveData(true);
    try {
      var reqBody = {
        "customername": getclientNameController.text,
        "mobileno": getmobileNoController.text,
        "address": getaddressController.text,
        "email": getEmailController.text,
        "password": getpasswordController.text,
        "deviceid": deviceMode,
        "logtime": "$currentDate|($currentTime)",
        "registrationlocation": googleLocation,
      };
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kuserregistration),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      CommonSuccessMessage temp =
          CommonSuccessMessage.fromJson(jsonDecode(response.body));
      dev.log(response.body);
      if (temp.success == "Success") {
        setcommonSuccessMessageModel(temp);
        commonMessage(context,
            errorTxt: temp.message.toString(),
            btnType: 3,
            buttons: [
              DialogButton(
                child: const Text(
                  'Okay',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(
                    builder: (context) {
                      return const MainDashBoard();
                    },
                  ));
                },
              )
            ]).show();
      } else {
        commonMessage(context, errorTxt: temp.message.toString()).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadSaveData(false);
    }
  }

  CommonSuccessMessage? commonSuccessMessageModel;
  CommonSuccessMessage? get getcommonSuccessMessageModel =>
      commonSuccessMessageModel;
  setcommonSuccessMessageModel(val) {
    commonSuccessMessageModel = val;
    notifyListeners();
  }

  Future<void> clearDetails(context) async {
    setloadPageRefData(true);
    try {
      getclientNameController.clear();
      getmobileNoController.clear();
      getaddressController.clear();
      getEmailController.clear();
      getpasswordController.clear();
      getreEnterPasswordController.clear();
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadPageRefData(false);
    }
  }
}
