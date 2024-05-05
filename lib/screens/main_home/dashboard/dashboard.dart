import 'package:flutter/material.dart';
import 'package:mobile_pos/screens/main_home/dashboard/bill_payment_screen/bill_payment.dart';
import 'package:mobile_pos/screens/main_home/dashboard/payment_records/payment_records.dart';
import 'package:mobile_pos/screens/main_home/login_screen/login_screen.dart';
import 'package:mobile_pos/screens/main_home/main_home.dart';
import 'package:mobile_pos/screens/main_home/product_details/product_details.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/widget/common_home_body.dart';
import 'package:mobile_pos/widget/common_image_btn.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

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
          title: 'Home Page',
          automaticallyImplyLeading: false,
          actions: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30), color: Colors.red),
              child: IconButton(
                  onPressed: () {
                    commonMessage(context,
                        errorTxt: "Are you sure singout?",
                        btnType: 3,
                        buttons: [
                          DialogButton(
                            child: Text(
                              "OK",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            color: Colors.blue,
                            onPressed: () {
                              Navigator.pushAndRemoveUntil(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return const MainDashBoard();
                                },
                              ), (route) => false);
                            },
                          ),
                          DialogButton(
                            color: Colors.redAccent,
                            child: Text(
                              "Close",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            ),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          )
                        ]).show();

                    // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                    //   builder: (context) {
                    //     return LoginScreen();
                    //   },
                    // ), (route) => false);
                  },
                  icon: const Icon(
                    Icons.power_settings_new_sharp,
                    color: kDefaultIconLightColor,
                    size: 25,
                    weight: 5,
                  )),
            )
          ],
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageBtn(
                        btnName: 'Bill Payment',
                        icon: Icon(
                          Icons.payments_rounded,
                          color: Colors.indigo.shade900,
                          size: 80,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const BillPaymentScreen(),
                              ));
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CommonImageBtn(
                        btnName: 'My Chat',
                        icon: Icon(
                          Icons.chat_outlined,
                          color: Colors.indigo.shade900,
                          size: 80,
                        ),
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonImageBtn(
                        btnName: 'Payment History',
                        icon: Icon(
                          Icons.history_outlined,
                          color: Colors.indigo.shade900,
                          size: 80,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const PaymentRecordsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      CommonImageBtn(
                        btnName: 'Price Details',
                        icon: Icon(
                          Icons.price_change_outlined,
                          color: Colors.indigo.shade900,
                          size: 80,
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const ProductDetailsScreen(),
                              ));
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
