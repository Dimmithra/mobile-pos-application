import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/user_reg_provider.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_btn.dart';
import 'package:mobile_pos/widget/common_input.dart';
import 'package:provider/provider.dart';

class UserRegistartionScreen extends StatefulWidget {
  const UserRegistartionScreen({super.key});

  @override
  State<UserRegistartionScreen> createState() => _UserRegistartionScreenState();
}

class _UserRegistartionScreenState extends State<UserRegistartionScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserRegProvider>(context, listen: false)
          // ;
          .clearDetails(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      backGroundColor: kBackgroundColor,
      title: 'User Registration',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<UserRegProvider>(
          builder: (context, userRegProvider, child) {
            if (userRegProvider.getloadPageRefData) {
              const CommonLoader();
            }
            return Form(
              key: formKey,
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
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Image(
                        image: AssetImage(
                          "assets/images/createAccount.png",
                        ),
                        height: 120,
                      ),
                      Text('Create Your Own Account',
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.indigo.shade900,
                              fontWeight: FontWeight.bold)),
                      Text('Welcome',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.indigo.shade500,
                              fontWeight: FontWeight.bold)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          hintText: 'client Name',
                          label: 'client Name',
                          controller: userRegProvider.getclientNameController,
                          fullboader: true,
                          isValidate: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          hintText: 'Mobile Number',
                          label: 'Mobile Number',
                          controller: userRegProvider.getmobileNoController,
                          fullboader: true,
                          isValidate: true,
                          maxLength: 10,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          hintText: 'Address',
                          label: 'Address',
                          controller: userRegProvider.getaddressController,
                          fullboader: true,
                          isValidate: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          hintText: 'Email',
                          label: 'Email',
                          controller: userRegProvider.getEmailController,
                          fullboader: true,
                          isValidate: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          isPassword: true,
                          hintText: 'password',
                          label: 'password',
                          controller: userRegProvider.getpasswordController,
                          fullboader: true,
                          isValidate: true,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CommonInput(
                          isPassword: true,
                          hintText: 'Re-Enter Passwors',
                          label: 'Re-Enter Passwors',
                          controller:
                              userRegProvider.getreEnterPasswordController,
                          fullboader: true,
                          isValidate: true,
                        ),
                      ),
                      userRegProvider.getloadSaveData
                          ? const CommonLoader()
                          : SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CommonBtn(
                                  bntName: 'Submite',
                                  onPress: () {
                                    if (formKey.currentState!.validate()) {
                                      userRegProvider
                                          .textFeildValidation(context);
                                    }
                                  },
                                ),
                              ),
                            )
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
