import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/pomotion_provider.dart';
import 'package:mobile_pos/providers/product_provider.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_image_btn.dart';
import 'package:mobile_pos/widget/product_Card.dart';
import 'package:provider/provider.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .getAllProduct(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "Product Details",
        body: Consumer<ProductDetailsProvider>(
            builder: (context, productDetailsProvider, child) {
          if (productDetailsProvider.loadingProductData) {
            return CommonLoader();
          }
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 275,
            ),
            itemCount:
                productDetailsProvider.allProductDetailsModelData!.data!.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(3.0),
                child: ProductCardImage(
                  productName:
                      '${productDetailsProvider.allProductDetailsModelData!.data![index].itemname}',
                  imageUrl:
                      '${productDetailsProvider.allProductDetailsModelData!.data![index].imageUrl}',
                  productWidget: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                          "${productDetailsProvider.allProductDetailsModelData!.data![index].companyName}"),
                      Text(
                          "${productDetailsProvider.allProductDetailsModelData!.data![index].itemdescription}"),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${productDetailsProvider.allProductDetailsModelData!.data![index].unitprice}"),
                          Text(
                              "qty: ${productDetailsProvider.allProductDetailsModelData!.data![index].quantity}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${productDetailsProvider.allProductDetailsModelData!.data![index].discountprice}"),
                        ],
                      ),
                    ],
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            },
          );
        }));
  }
}
