import 'dart:ffi';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class AuthProvider extends ChangeNotifier {
  Future<void> verficationAppdata(context) async {
    try {
      mobileMake(context);
    } catch (e) {}
  }

  Future<void> mobileMake(context) async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final deviceInfo = await deviceInfoPlugin.deviceInfo;
      final allInfo = deviceInfo.data;
      dev.log({allInfo}.toString());
    } catch (e) {}
  }
}
