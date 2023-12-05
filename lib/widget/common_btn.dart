import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';

class CommonBtn extends StatelessWidget {
  const CommonBtn({
    super.key,
    required this.bntName,
    required this.onPress,
    this.backgroundColor,
  });

  final String bntName;
  final Function() onPress;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        backgroundColor: kCommondarkBlue,
      ),
      onPressed: onPress,
      child: Text(
        bntName,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 18,
        ),
      ),
    );
  }
}
