import 'package:flutter/material.dart';
import 'package:mobile_pos/utils/color.dart';

class CommonInput extends StatelessWidget {
  const CommonInput({
    super.key,
    this.controller,
    required this.hintText,
    required this.label,
    this.filled,
    this.suffix,
    this.backgroundcolor,
    this.fullboader = false,
    this.keyBoardType = false,
    this.fillColor,
    this.lableColor = false,
  });
  final TextEditingController? controller;
  final String hintText;
  final String label;
  final bool? filled;
  final Widget? suffix;
  final Color? backgroundcolor;
  final bool fullboader;
  final bool keyBoardType;
  final Color? fillColor;
  final bool lableColor;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType:
          keyBoardType ? TextInputType.number : TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: lableColor ? Colors.white : Colors.black),
        label: Text(
          label,
        ),
        labelStyle: TextStyle(color: lableColor ? Colors.white : Colors.black),
        filled: filled,
        suffixIcon: suffix,
        fillColor: fillColor,
        enabledBorder: fullboader
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  color: kCommondarkBlue,
                ))
            : null,
        focusedBorder: fullboader
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(
                  color: kCommondarkBlue,
                ),
              )
            : UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kCommonBlack,
                ),
              ),
      ),
    );
  }
}
