import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:mobile_pos/model/login_verification_model.dart';
import 'package:mobile_pos/screens/main_home/main_home.dart';
// import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_pos/utils/message.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';
import 'package:mobile_pos/utils/url.dart';

class AuthProvider extends ChangeNotifier {
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());
  Future<void> verficationAppdata(context) async {
    // String deviceID = await getDeviceId();
    String deviceMake = await getDeviceMake();
    String deviceModel = await getDeviceModel();
    try {
      // var reqBody = {
      //   "devieid": 'deviceID',
      //   "devicemake": deviceMake,
      //   "deviemodel": deviceModel,
      //   "location": "",
      //   "time": "$currentDate ($currentTime)",
      //   "cus_code": ""
      // };
      // dev.log(reqBody.toString());
      // var response = await http.post(
      //   Uri.parse(kdevicerecord),
      //   headers: {"Content-Type": "application/json"},
      //   body: jsonEncode(reqBody),
      // );

      // LoginVerificationModel temp =
      //     LoginVerificationModel.fromJson(jsonDecode(response.body));
      // dev.log(response.body);

      // if (temp.success == 'Success') {
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute<void>(
              builder: (BuildContext context) => const MainDashBoard()),
          (route) => false);
      // } else {
      //   errorMessage(context, errorTxt: 'Security Issue').show();
      // }
    } catch (e) {
      dev.log(e.toString());
    }
  }

  // Future<String> getDeviceId() async {
  //   final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  //   String? deviceId;
  //   if (Platform.isAndroid) {
  //     // deviceId = await GetMac.macAddress;
  //     deviceId = await PlatformDeviceId.getDeviceId;
  //     // final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
  //     // deviceId = androidInfo
  //     //     .id; // Returns the Android ID which is unique to each combination of app-signing key, user, and device.
  //   } else if (Platform.isIOS) {
  //     final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
  //     deviceId = iosInfo
  //         .identifierForVendor!; // Returns the ID for Advertising, which is unique to each device and the app vendor.
  //   }
  //   return deviceId!;
  // }

  Future<String> getDeviceMake() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceMake;
    if (Platform.isAndroid) {
      // deviceId = await GetMac.macAddress;
      // deviceMake = await PlatformDeviceId.getDeviceId;
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMake = androidInfo.brand;
      //     .id; // Returns the Android ID which is unique to each combination of app-signing key, user, and device.
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMake = iosInfo
          .name; // Returns the ID for Advertising, which is unique to each device and the app vendor.
    }
    return deviceMake!;
  }

  Future<String> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceMake;
    if (Platform.isAndroid) {
      // deviceId = await GetMac.macAddress;
      // deviceMake = await PlatformDeviceId.getDeviceId;
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMake = androidInfo.model;
      //     .id; // Returns the Android ID which is unique to each combination of app-signing key, user, and device.
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMake = iosInfo
          .model; // Returns the ID for Advertising, which is unique to each device and the app vendor.
    }
    return deviceMake!;
  }
}
