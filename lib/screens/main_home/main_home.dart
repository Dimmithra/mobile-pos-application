import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/home_provider.dart';
import 'package:mobile_pos/screens/main_home/user_regestration/user_reg.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_image_btn.dart';
import 'package:provider/provider.dart';

class MainDashBoard extends StatefulWidget {
  const MainDashBoard({super.key});

  @override
  State<MainDashBoard> createState() => _MainDashBoardState();
}

class _MainDashBoardState extends State<MainDashBoard> {
  @override
  void initState() {
    Provider.of<HomeProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) {
        return CommonHomeScreen(
          // imageUrl: AssetImage('assets/images/main_home_title.png'),
          homeTitile: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                // crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            // Container(
                            //   decoration: BoxDecoration(
                            //     image: DecorationImage(
                            //       image:
                            //           AssetImage('assets/images/image_1.JPG'),
                            //       fit: BoxFit.cover,
                            //     ),
                            //   ),
                            // ),
                            const Icon(
                              Icons.date_range_outlined,
                              color: kCommonWhite,
                              size: 30,
                            ),
                            Text(
                              homeProvider.currentDate,
                              style: const TextStyle(
                                color: kCommonWhite,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.lock_clock,
                              color: kCommonWhite,
                              size: 30,
                            ),
                            Text(
                              homeProvider.currentTime,
                              selectionColor: kCommonWhite,
                              style: TextStyle(
                                color: kCommonWhite,
                                fontSize: 14,
                              ),
                              // strutStyle: StrutStyle(
                              //   fontSize: 18,
                              //   fontWeight: FontWeight.bold,
                              // )
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  color: kCommonBlack,
                  fontSize: 24,
                ),
              )
            ],
          ),
          homeBody: Padding(
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
                    Color.fromARGB(255, 195, 210, 213),
                  ],
                ),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageBtn(
                        btnName: 'Promotion Details',
                        imageUrl: const AssetImage(
                          'assets/images/promotion_icon.PNG',
                        ),
                        onTap: () {
                          print('object');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'Price Details',
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
                        btnName: 'Sign In',
                        imageUrl: const AssetImage(
                          'assets/images/home_login.JPG',
                        ),
                        onTap: () {
                          print('object');
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'Create Account',
                        imageUrl: const AssetImage(
                          'assets/images/user_regestration.PNG',
                        ),
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UserRegistartionScreen(),
                              ),
                            );
                          });
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
