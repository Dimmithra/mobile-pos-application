import 'package:flutter/material.dart';

class CommonMainScreen extends StatefulWidget {
  const CommonMainScreen({
    super.key,
    required this.title,
    this.appBarColor,
    required this.body,
    this.titleTextColor,
    this.backGroundColor,
    this.centerTitle,
    this.drawer,
    this.actions,
    this.automaticallyImplyLeading = true,
  });
  final String title;
  final Color? appBarColor;
  final Color? titleTextColor;
  final Widget body;
  final Color? backGroundColor;
  final Widget? centerTitle;
  final Widget? drawer;
  final List<Widget>? actions;
  final bool? automaticallyImplyLeading;
  @override
  State<CommonMainScreen> createState() => _CommonMainScreenState();
}

class _CommonMainScreenState extends State<CommonMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: widget.drawer,
      appBar: AppBar(
        centerTitle: true,
        actions: widget.actions,
        // automaticallyImplyLeading: widget.automaticallyImplyLeading,
        titleTextStyle: TextStyle(
            fontSize: 20,
            color: widget.titleTextColor ?? Colors.white,
            fontWeight: FontWeight.bold),
        leading: widget.centerTitle,
        // actions: [IconButton(onPressed: () {}, icon: Icon(Icons.abc))],
        backgroundColor: widget.appBarColor ?? Colors.green.shade700,
        title: Text(
          widget.title,
        ),
      ),
      backgroundColor:
          widget.backGroundColor ?? const Color.fromARGB(255, 236, 236, 236),
      body: widget.body,
    );
  }
}
