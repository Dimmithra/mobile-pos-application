import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/widget/common_inpput.dart';
import 'package:provider/provider.dart';

class UserRegistartionScreen extends StatefulWidget {
  const UserRegistartionScreen({super.key});

  @override
  State<UserRegistartionScreen> createState() => _UserRegistartionScreenState();
}

class _UserRegistartionScreenState extends State<UserRegistartionScreen> {
  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      backGroundColor: kBackgroundColor,
      title: 'User Registration',
      body: SingleChildScrollView(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'client Name',
                label: 'client Name',
                // filled: true,
                fullboader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'Mobile Number',
                label: 'Mobile Number',
                // filled: true,
                fullboader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'Address',
                label: 'Address',
                // filled: true,
                fullboader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'Email',
                label: 'Email',
                // filled: true,
                fullboader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'password',
                label: 'password',
                // filled: true,
                fullboader: true,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CommonInput(
                hintText: 'Re-Enter Passwors',
                label: 'Re-Enter Passwors',
                // filled: true,
                fullboader: true,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
