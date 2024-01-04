import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/common_main.dart';
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
      Provider.of<LogingProvider>(context, listen: false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: 'Promotion Screen',
      body: SingleChildScrollView(child: Consumer(
        builder: (context, value, child) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Text('Item name'),
                      Text('Market price'),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      )),
    );
  }
}
