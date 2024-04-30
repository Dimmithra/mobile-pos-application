import 'package:flutter/material.dart';

class CommonHomeScreen extends StatelessWidget {
  const CommonHomeScreen({
    super.key,
    required this.homeTitile,
    this.titleBackgroundColor,
    required this.homeBody,
    // required this.imageUrl,
  });

  final Widget homeTitile;
  final Colors? titleBackgroundColor;
  final Widget homeBody;
  // final AssetImage imageUrl;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.green.shade50,
        body: Container(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 175,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40),
                          bottomRight: Radius.circular(40)),
                      // color: Colors.blueGrey,
                      gradient: LinearGradient(colors: [
                        Colors.green.shade900,
                        Colors.green.shade700,
                        Colors.green.shade400,
                        // Color.fromARGB(255, 183, 183, 183),
                      ]),
                      // image: DecorationImage(
                      //   image: imageUrl,
                      //   fit: BoxFit.cover,
                      // ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurStyle: BlurStyle.outer,
                          blurRadius: 30,
                        )
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          homeTitile,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              //   decoration: BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/splashScreen.jpeg"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 20, bottom: 30),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: homeBody,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
