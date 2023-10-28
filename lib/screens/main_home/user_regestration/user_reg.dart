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
              child: Column(
                children: [
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
                      hintText: 'Re-Enter Passwors',
                      label: 'Re-Enter Passwors',
                      controller: userRegProvider.getreEnterPasswordController,
                      fullboader: true,
                      isValidate: true,
                    ),
                  ),
                  userRegProvider.getloadSaveData
                      ? const CommonLoader()
                      : CommonBtn(
                          bntName: 'Submite',
                          onPress: () {
                            if (formKey.currentState!.validate()) {
                              userRegProvider.textFeildValidation(context);
                            }
                          },
                        )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
