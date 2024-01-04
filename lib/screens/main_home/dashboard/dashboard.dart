import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_image_btn.dart';
import 'package:provider/provider.dart';

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
          title: 'title',
          body: SingleChildScrollView(),
        );
      },
    );
  }
}
