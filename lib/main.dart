import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/auth_provider.dart';
import 'package:mobile_pos/providers/bill_provider.dart';
import 'package:mobile_pos/providers/chat_provider.dart';
import 'package:mobile_pos/providers/home_provider.dart';
import 'package:mobile_pos/providers/login_provider.dart';
import 'package:mobile_pos/providers/pomotion_provider.dart';
import 'package:mobile_pos/providers/product_provider.dart';
import 'package:mobile_pos/providers/user_reg_provider.dart';

import 'screens/splash/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => UserRegProvider()),
        ChangeNotifierProvider(create: (_) => LogingProvider()),
        ChangeNotifierProvider(create: (_) => PromotionProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (_) => BillProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobile Pos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
