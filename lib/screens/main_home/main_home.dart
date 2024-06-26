import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/home_provider.dart';
import 'package:mobile_pos/screens/main_home/login_screen/login_screen.dart';
import 'package:mobile_pos/screens/main_home/product_details/product_details.dart';
import 'package:mobile_pos/screens/main_home/promotion_screen/promotion_screen.dart';
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
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
          homeBody: Padding(
            padding:
                EdgeInsets.only(top: MediaQuery.of(context).size.height / 15),
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
                        btnName: 'Promotion Details',
                        imageUrl: "assets/images/promotion_icon.PNG",
                        // AssetImage(
                        //   'assets/images/promotion_icon.PNG',
                        // ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PrommotionScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'Product Details',
                        imageUrl: 'assets/images/productImage.png',
                        height: 80,
                        width: 120,
                        // const AssetImage(
                        //   'assets/images/price_details.PNG',
                        // ),
                        backgroundColor: Colors.white,
                        onTap: () {
                          print('object');
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductDetailsScreen(),
                              ));
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
                        imageUrl: 'assets/images/home_login.JPG',
                        // const AssetImage(
                        //   'assets/images/home_login.JPG',
                        // ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      CommonImageBtn(
                        btnName: 'Create Account',
                        imageUrl: 'assets/images/user_regestration.PNG',
                        //  const AssetImage(
                        //   'assets/images/user_regestration.PNG',
                        // ),
                        onTap: () {
                          setState(() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UserRegistartionScreen(),
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
