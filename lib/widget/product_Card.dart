import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProductCardImage extends StatelessWidget {
  const ProductCardImage({
    super.key,
    this.productName,
    this.onTap,
    required this.imageUrl,
    this.productWidget,
    this.backgroundColor,
  });
  final String? productName;
  final Function()? onTap;
  final String imageUrl;
  final Widget? productWidget;
  final Color? backgroundColor;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          border: Border.all(color: Colors.black),
          color: backgroundColor ?? Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.max,
            children: [
              CachedNetworkImage(
                imageUrl: imageUrl,
                height: 100,
                width: 100,
                placeholder: (context, url) {
                  return CircularProgressIndicator(
                    color: Colors.green,
                  );
                },
                errorWidget: (context, url, error) {
                  return SizedBox.shrink();
                },
                // fadeInDuration:
                //     const Duration(seconds: 3),
              ),
              Divider(
                color: Colors.grey,
              ),
              Column(
                children: [
                  Text(
                    productName!,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    child: productWidget,
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
