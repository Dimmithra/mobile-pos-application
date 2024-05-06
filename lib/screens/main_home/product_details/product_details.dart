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
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GridView.builder(
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                mainAxisExtent: 275,
              ),
              itemCount: productDetailsProvider
                  .allProductDetailsModelData!.data!.length,
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
                          "${productDetailsProvider.allProductDetailsModelData!.data![index].companyName}",
                        ),
                        Text(
                            "${productDetailsProvider.allProductDetailsModelData!.data![index].itemdescription}"),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Price${productDetailsProvider.allProductDetailsModelData!.data![index].unitprice}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "qty: ${productDetailsProvider.allProductDetailsModelData!.data![index].quantity}",
                              style: const TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        productDetailsProvider.allProductDetailsModelData!
                                .data![index].discountprice!.isNotEmpty
                            ? Container(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: EdgeInsets.all(2),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          gradient: LinearGradient(colors: [
                                            Colors.red.shade100,
                                            Colors.red.shade200
                                          ])),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.remove,
                                            color: Colors.grey.shade600,
                                            size: 20,
                                          ),
                                          Text(
                                            "${productDetailsProvider.allProductDetailsModelData!.data![index].discountprice}",
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "${productDetailsProvider.allProductDetailsModelData!.data![index].newMarketPrice}",
                                      style: TextStyle(
                                        color: Colors.indigo.shade900,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            : const SizedBox.shrink(),
                      ],
                    ),
                    backgroundColor: Colors.white,
                  ),
                );
              },
            ),
          );
        }));
  }
}
