import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_pos/providers/auth_provider.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:provider/provider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ConnectivityResult connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    // checkDeviceSeurite();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      chechInternetConnection();
      _connectivitySubscription =
          _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
      Provider.of<AuthProvider>(context, listen: false)
          .permisionChecked(context);
      // Provider.of<AuthProvider>(context, listen: false)
      //     .determinePosition(context);
    });
    super.initState();
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  Future<void> chechInternetConnection() async {
    ConnectivityResult? result;
    try {
      result = await _connectivity.checkConnectivity();
      if (result == ConnectivityResult.wifi ||
          result == ConnectivityResult.mobile) {
        print('Connection Success');
      } else {
        print('No internet');
        await commonMessage(context,
                errorTxt: 'Internet Connection Issue', btnType: 1)
            .show();
      }
    } on PlatformException catch (e) {
      print(e);
      return;
    }
    if (!mounted) {
      return Future.value(null);
    }

    return _updateConnectionStatus(result);
  }

  Future<void> _updateConnectionStatus(ConnectivityResult result) async {
    setState(() {
      connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  colors: [Colors.green.shade100, Colors.green.shade50])
              // image: DecorationImage(
              //   image: AssetImage("assets/images/main_home_title.png"),
              //   fit: BoxFit.cover,
              // ),
              ),
          child: Center(
              child: Image(
            image: AssetImage("assets/images/splash_image.png"),
            height: MediaQuery.of(context).size.width / 2,
          )),
        ),
      ),
    );
  }
}
