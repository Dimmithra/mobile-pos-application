import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:geolocator/geolocator.dart';
import 'package:mobile_pos/model/login_verification_model.dart';
import 'package:mobile_pos/screens/main_home/main_home.dart';
import 'package:geocoding/geocoding.dart';
// import 'package:platform_device_id/platform_device_id.dart';
import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pos/utils/url.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:rflutter_alert/rflutter_alert.dart';

class AuthProvider extends ChangeNotifier {
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());

  final storage = const FlutterSecureStorage();

  //location services
  Future<Position> determinePosition(context) async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      commonMessage(context,
          errorTxt:
              'Location is off, Please Enable the Location in the System Settings',
          btnType: 2,
          buttons: [
            DialogButton(
              child: const Text('Okay',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.pop(context);
                // Navigator.pop(context);
              },
            )
          ]).show();

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // return
        dev.log('Location permissions are denied');
        verficationAppdata(context);
        // Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  //google map location
  bool loadMapData = false;
  bool get getloadMapData => loadMapData;
  setloadMapData(val) {
    loadMapData = val;
    notifyListeners();
  }

  String? geoLocation;
  String location = 'pending Location';
  String latitude = '';
  String longatude = '';
  Future<void> googleAddressLocation(Position position) async {
    setloadMapData(true);
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    dev.log(placemarks.toString());
    try {
      dev.log(placemarks.toString());

      Placemark place = placemarks[0];
      latitude = '${position.latitude}';
      longatude = '${position.longitude}';
      location =
          '${place.street},${place.administrativeArea},${place.subAdministrativeArea},${place.subLocality},${place.country},${place.postalCode},${place.isoCountryCode}';
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadMapData(false);
    }
  }

  Future<void> permisionChecked(context) async {
    Position position = await determinePosition(context);
    var googleLocationPermision =
        await storage.read(key: kAccessGoogleLocation);
    dev.log('location permintion: $googleLocationPermision');
    if (googleLocationPermision == 'true') {
      await googleAddressLocation(position);
      await verficationAppdata(context);
    } else {
      commonMessage(context,
          errorTxt:
              'Allow to also access your location even when you are using the app?',
          btnType: 3,
          buttons: [
            DialogButton(
              color: Colors.red,
              child: const Text('allow once',
                  style: TextStyle(
                      color: kCommonWhite, fontWeight: FontWeight.bold)),
              onPressed: () async {
                await googleAddressLocation(position);
                await verficationAppdata(context);
                storage.write(key: kAccessGoogleLocation, value: 'true');
              },
            ),
            DialogButton(
              color: Colors.blue,
              child: const Text("Don't allow",
                  style: TextStyle(
                      color: kCommonWhite, fontWeight: FontWeight.bold)),
              onPressed: () async {
                await verficationAppdata(context);
                storage.write(key: kAccessGoogleLocation, value: 'false');
              },
            )
          ]).show();
    }
  }

  Future<void> verficationAppdata(context) async {
    String deviceID = await getDeviceid();
    String deviceMake = await getDeviceMake();
    String deviceModel = await getDeviceModel();
    try {
      var reqBody = {
        "devieid": deviceID,
        "devicemake": deviceMake,
        "deviemodel": deviceModel,
        "location": location,
        "time": "$currentDate ($currentTime)",
        "cus_code": ""
      };
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kdevicerecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      LoginVerificationModel temp =
          LoginVerificationModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'Success') {
        storage.write(key: kDeviceMake, value: deviceMake);
        storage.write(key: kDeviceModel, value: deviceModel);
        storage.write(key: kGoogleLocation, value: location);
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute<void>(
                builder: (BuildContext context) => const MainDashBoard()),
            (route) => false);
      } else {
        commonMessage(context, errorTxt: 'Security Issue').show();
      }
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

  Future<String> getDeviceid() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceMake;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMake = androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMake = iosInfo.systemVersion;
    }
    return deviceMake!;
  }

  Future<String> getDeviceMake() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceMake;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMake = androidInfo.brand;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMake = iosInfo.name;
    }
    return deviceMake!;
  }

  Future<String> getDeviceModel() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    String? deviceMake;
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      deviceMake = androidInfo.model;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      deviceMake = iosInfo.model;
    }
    return deviceMake!;
  }
}
