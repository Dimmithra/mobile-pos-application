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
          return ListView.builder(
            itemCount: promotionProvider.getallPromotionModelData!.data!.length,
            itemBuilder: (context, index) {
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Text(
                              '${promotionProvider.getallPromotionModelData!.data![index].mainTitle}'),
                          Text('Market price'),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
