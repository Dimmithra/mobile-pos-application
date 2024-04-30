import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/pomotion_provider.dart';
import 'package:mobile_pos/utils/color.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:provider/provider.dart';

import '../../../providers/login_provider.dart';

class PrommotionScreen extends StatefulWidget {
  const PrommotionScreen({super.key});

  @override
  State<PrommotionScreen> createState() => _PrommotionScreenState();
}

class _PrommotionScreenState extends State<PrommotionScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PromotionProvider>(context, listen: false)
          .getAllPromotionData(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      appBarColor: kAppBarColor,
      title: 'Promotion Screen',
      body: Consumer<PromotionProvider>(
        builder: (context, promotionProvider, child) {
          if (promotionProvider.getloadPromotionData) {
            return const CommonLoader();
          }
          return promotionProvider.getallPromotionModelData!.data!.isNotEmpty
              ? ListView.builder(
                  itemCount:
                      promotionProvider.getallPromotionModelData!.data!.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            gradient: LinearGradient(colors: [
                              Colors.purple.shade400,
                              Colors.deepPurple.shade300
                            ])),
                        child: Padding(
                          padding: const EdgeInsets.all(6.0),
                          child: Row(
                            // crossAxisAlignment: CrossAxisAlignment.start,

                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                padding: EdgeInsets.only(top: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.green,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '${promotionProvider.getallPromotionModelData!.data![index].promotionDate}',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 1.5,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 50),
                                      child: Text(
                                        '${promotionProvider.getallPromotionModelData!.data![index].mainTitle}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '${promotionProvider.getallPromotionModelData!.data![index].subTitle}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width / 2,
                                    child: Padding(
                                      padding: const EdgeInsets.all(8),
                                      child: Text(
                                        '${promotionProvider.getallPromotionModelData!.data![index].discription}',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                )
              : Container(
                  child: Text("NO Promotion recode Founded"),
                );
        },
      ),
    );
  }
}
