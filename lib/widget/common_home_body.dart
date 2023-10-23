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
        backgroundColor: const Color.fromARGB(255, 204, 211, 213),
        body: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30),
                        bottomRight: Radius.circular(30)),
                    // color: Colors.blueGrey,
                    gradient: LinearGradient(colors: [
                      Colors.blue,
                      Color.fromARGB(255, 183, 183, 183),
                      Colors.blue
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
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SingleChildScrollView(
                child: homeBody,
              ),
            )
          ],
        ),
      ),
    );
  }
}
