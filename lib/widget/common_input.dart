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
    this.isValidate = false,
    this.maxLength,
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
  final bool isValidate;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      maxLength: maxLength,
      validator: (text) {
        if (isValidate) {
          if (text == null || text.isEmpty) {
            return ' $hintText is Required';
          }
          return null;
        }

        return null;
      },
      keyboardType:
          keyBoardType ? TextInputType.number : TextInputType.multiline,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: lableColor ? Colors.white : Colors.black),
        label: Text(
          label,
        ),
        errorBorder: fullboader
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide(color: Colors.red))
            : null,
        labelStyle: TextStyle(color: lableColor ? Colors.white : Colors.black),
        filled: filled,
        suffixIcon: suffix,
        fillColor: fillColor,
        enabledBorder: fullboader
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: kCommondarkBlue,
                ))
            : null,
        focusedBorder: fullboader
            ? OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: const BorderSide(
                  color: kCommondarkBlue,
                ),
              )
            : const UnderlineInputBorder(
                borderSide: BorderSide(
                  color: kCommonBlack,
                ),
              ),
      ),
    );
  }
}
