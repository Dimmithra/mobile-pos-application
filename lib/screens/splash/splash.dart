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
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  @override
  void initState() {
    // checkDeviceSeurite();
    chechInternetConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_updateConnectionStatus);
    super.initState();
    Provider.of<AuthProvider>(context, listen: false)
        .verficationAppdata(context);
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
        await errorMessage(context,
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
      _connectionStatus = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/splashScreen.jpeg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    );
  }
}
