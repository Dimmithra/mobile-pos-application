import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonHomeScreen(
        homeTitile: Row(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_circle_left,
                    size: 40,
                    color: Colors.black,
                    opticalSize: 25,
                  ),
                ),
              ],
            )
          ],
        ),
        homeBody: SingleChildScrollView(
          child: Consumer(
            builder: (context, value, child) {
              return Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 20, left: 15, right: 15),
                    child: Container(
                      height: 300,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Sign UP',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blue,
                                        fontWeight: FontWeight.bold))
                              ],
                            ),
                            SizedBox(
                              height: 40,
                            ),
                            CommonInput(
                              suffix: Icon(Icons.person),
                              hintText: 'Email Address',
                              label: 'Enter Your Email Address',
                              fullboader: true,
                              backgroundcolor: Colors.black,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            },
          ),
        ));
    // CommonMainScreen(
    //     title: 'Login',
    //     body: SingleChildScrollView(
    //       child: Consumer(
    //         builder: (context, value, child) {
    //           return CommonLoader();
    //         },
    //       ),
    //     ));
  }
}
