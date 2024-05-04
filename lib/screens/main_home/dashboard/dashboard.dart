import 'package:flutter/material.dart';
import 'package:mobile_pos/screens/main_home/login_screen/login_screen.dart';
import 'package:mobile_pos/screens/main_home/main_home.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_image_btn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../../../providers/home_provider.dart';

class Dashbaord extends StatefulWidget {
  const Dashbaord({super.key});

  @override
  State<Dashbaord> createState() => _DashbaordState();
}

class _DashbaordState extends State<Dashbaord> {
  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return CommonMainScreen(
          title: 'Home Page',
          actions: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.red),
              child: IconButton(
                  onPressed: () {
                    commonMessage(context,
                        errorTxt: "Are you sure singout?",
                        btnType: 3,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return const MainDashBoard();
                                },
                              ), (route) => false);
                            },
                          ),
                          DialogButton(
                            color: Colors.redAccent,
                            child: Text(
                              "Close",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ]).show();

                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return LoginScreen();
                    //   },
                    // ), (route) => false);
                  },
                  icon: const Icon(
                    Icons.power_settings_new_sharp,
                    color: kDefaultIconLightColor,
                    size: 25,
                    weight: 5,
                  )),
            )
          ],
          body: SingleChildScrollView(),
        );
      },
    );
  }
}
