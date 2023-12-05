import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/login_prvider.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_btn.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_input.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final formKey = GlobalKey<FormState>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<LogingProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: 'Login',
        titleTextColor: kCommonBlack,
        appBarColor: const Color.fromARGB(255, 145, 220, 255),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/login.jpg"),
                fit: BoxFit.cover,
              ),
              // color: Colors.grey,
            ),
            height: MediaQuery.of(context).size.height - (50),
            child: Consumer<LogingProvider>(
              builder: (context, logingProvider, child) {
                if (logingProvider.getloginLoader) {
                  return const CommonLoader();
                }
                return Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100, left: 15, right: 15),
                        child: Container(
                          height: 400,
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            // gradient: const SweepGradient(colors: [
                            //   Colors.transparent,
                            //   // Color.fromARGB(255, 142, 204, 255),
                            //   Colors.white,
                            //   Colors.transparent
                            // ]),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text('Sign Up',
                                        style: TextStyle(
                                            fontSize: 30,
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold))
                                  ],
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                CommonInput(
                                  suffix: Icon(Icons.person,
                                      color: Colors.black, size: 35),
                                  hintText: 'Email Address',
                                  label: 'Enter Your Email Address',
                                  fullboader: true,
                                  isValidate: true,
                                  backgroundcolor: Colors.black,
                                  controller: logingProvider.getEmailController,
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                CommonInput(
                                  suffix: Icon(Icons.password_sharp,
                                      color: Colors.black, size: 35),
                                  hintText: 'Password',
                                  isValidate: true,
                                  label: 'Enter Your Password',
                                  fullboader: true,
                                  backgroundcolor: Colors.black,
                                  controller:
                                      logingProvider.getPasswordController,
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: CommonBtn(
                                    // backgroundColor: Colors.blue,
                                    bntName: 'Sign In',
                                    onPress: () {
                                      if (formKey.currentState!.validate()) {}
                                    },
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ));
  }
}
