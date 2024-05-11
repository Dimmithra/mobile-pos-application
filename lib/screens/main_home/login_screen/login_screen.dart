import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_pos/providers/login_provider.dart';
import 'package:mobile_pos/screens/main_home/dashboard/dashboard.dart';
import 'package:mobile_pos/screens/main_home/user_regestration/user_reg.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/key_const.dart';
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
      // Provider.of<LogingProvider>(context, listen: false).readUserData();
      // Provider.of<LogingProvider>(context, listen: false).clearLoginData();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final storage = const FlutterSecureStorage();

    var emailStore = storage.read(key: kEmail);
    var passwordStore = storage.read(key: kPassword);
    var userLoginvaldator = storage.read(key: kValidateUserData);

    return CommonMainScreen(
        title: 'Sign Up',
        titleTextColor: kCommonWhite,
        appBarColor: kAppBarColor,
        body: Container(
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white70,
          ])),
          child: SingleChildScrollView(
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
                        padding:
                            const EdgeInsets.only(top: 50, left: 15, right: 15),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                            ),
                            gradient: const SweepGradient(colors: [
                              Colors.white70,
                              Colors.white,
                            ]),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Column(
                              children: [
                                const Image(
                                  image: AssetImage(
                                    "assets/images/loginImage.jpg",
                                  ),
                                  height: 120,
                                ),
                                Text('Login In To Continue',
                                    style: TextStyle(
                                        fontSize: 22,
                                        color: Colors.indigo.shade900,
                                        fontWeight: FontWeight.bold)),
                                Text('Welcome',
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.indigo.shade500,
                                        fontWeight: FontWeight.bold)),
                                const SizedBox(
                                  height: 20,
                                ),
                                CommonInput(
                                  suffix: const Icon(Icons.person,
                                      color: Colors.black, size: 35),
                                  hintText:
                                      "${userLoginvaldator == 'true' ? emailStore : "Enter Your Email Address"}",
                                  label: ' Enter Your Email Address',
                                  fullboader: true,
                                  isValidate: true,
                                  backgroundcolor: Colors.black,
                                  controller: logingProvider.getEmailController,
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                CommonInput(
                                  isPassword: true,
                                  suffix: const Icon(Icons.password_sharp,
                                      color: Colors.black, size: 35),
                                  hintText:
                                      '${userLoginvaldator == 'true' ? passwordStore : "Enter Your Password"}',
                                  isValidate: true,
                                  label: 'Enter Your Password',
                                  fullboader: true,
                                  backgroundcolor: Colors.black,
                                  controller:
                                      logingProvider.getPasswordController,
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width,
                                  child: logingProvider.getloadingLoginData
                                      ? const CommonLoader()
                                      : CommonBtn(
                                          // backgroundColor: Colors.blue,
                                          bntName: 'Sign In',
                                          onPress: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              logingProvider
                                                  .loginProccess(context);
                                            }
                                          },
                                        ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        top: 15,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(context,
                                              MaterialPageRoute(
                                            builder: (context) {
                                              return const UserRegistartionScreen();
                                            },
                                          ));
                                        },
                                        child: Text(
                                          "Create Account",
                                          style: TextStyle(
                                            color: Colors.indigo.shade600,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
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
