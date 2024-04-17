import 'package:flutter/material.dart';

class CommonImageBtn extends StatelessWidget {
  const CommonImageBtn({
    super.key,
    this.btnName,
    this.onTap,
    required this.imageUrl,
    this.backgroundColor,
  });
  final String? btnName;
  final Function()? onTap;
  final String imageUrl;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 150,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: backgroundColor ?? Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Image(
                image: AssetImage(imageUrl),
                width: 80,
                height: 80,
              ),
              Container(
                color: Colors.transparent,
                child: Text(
                  btnName!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
