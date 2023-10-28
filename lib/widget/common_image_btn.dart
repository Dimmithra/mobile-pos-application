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
  final AssetImage imageUrl;
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
          color: backgroundColor ?? Colors.blue,
          image: DecorationImage(
            image: imageUrl,
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.transparent,
                child: Text(
                  btnName!,
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
