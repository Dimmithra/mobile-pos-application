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
          title: 'Welcome',
          body: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Container(
              padding: const EdgeInsets.all(8.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
                gradient: RadialGradient(
                  colors: [
                    Colors.white,
                    Colors.transparent,
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageBtn(
                        btnName: 'My Shopping',
                        imageUrl: const AssetImage(
                          'assets/images/promotion_icon.PNG',
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'My ChatBox',
                        imageUrl: const AssetImage(
                          'assets/images/price_details.PNG',
                        ),
                        backgroundColor: Colors.white,
                        onTap: () {
                          print('object');
                        },
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageBtn(
                        btnName: 'My Payments',
                        imageUrl: const AssetImage(
                          'assets/images/home_login.JPG',
                        ),
                        onTap: () {},
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'Promotions',
                        imageUrl: const AssetImage(
                          'assets/images/user_regestration.PNG',
                        ),
                        onTap: () {
                          setState(() {});
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
