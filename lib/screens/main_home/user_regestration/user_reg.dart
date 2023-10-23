import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/common_main.dart';
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
      title: 'User Registration',
      body: SingleChildScrollView(),
    );
  }
}
