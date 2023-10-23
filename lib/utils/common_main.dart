import 'package:flutter/material.dart';

class CommonMainScreen extends StatelessWidget {
  const CommonMainScreen({
    super.key,
    required this.title,
    this.appBarColor,
    required this.body,
    this.titleTextColor,
    this.backGroundColor,
    this.centerTitle,
    this.drawer,
  });
  final String title;
  final Color? appBarColor;
  final Color? titleTextColor;
  final Widget body;
  final Color? backGroundColor;
  final Widget? centerTitle;
  final Widget? drawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: AppBar(
        centerTitle: true,
        titleTextStyle: TextStyle(
          fontSize: 20,
          color: titleTextColor ?? Colors.white,
        ),
        leading: centerTitle,
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
        backgroundColor: appBarColor ?? Colors.blue,
        title: Text(
          title,
        ),
      ),
      backgroundColor:
          backGroundColor ?? const Color.fromARGB(255, 236, 236, 236),
      body: body,
    );
  }
}
