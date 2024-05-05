import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/bill_provider.dart';
import 'package:mobile_pos/providers/product_provider.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_btn.dart';
import 'package:mobile_pos/widget/common_search_dropdown.dart';
import 'package:provider/provider.dart';
import 'dart:developer' as dev;
import 'package:intl/intl.dart';

class BillPaymentScreen extends StatefulWidget {
  const BillPaymentScreen({super.key});

  @override
  State<BillPaymentScreen> createState() => _BillPaymentScreenState();
}

class _BillPaymentScreenState extends State<BillPaymentScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .getAllProduct(context);
      Provider.of<ProductDetailsProvider>(context, listen: false)
          .setloadCompleBilldate(false);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "Bill Payment",
        body: SingleChildScrollView(
          child: Consumer2<BillProvider, ProductDetailsProvider>(
            builder: (context, billProvider, productDetailsProvider, child) {
              if (productDetailsProvider.getloadingProductData) {
                return const CommonLoader();
              }
              return Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: productDetailsProvider.getloadCompleBilldate
                            ? const CommonLoader()
                            : CommonBtn(
                                bntName: "Complete Shopping",
                                backgroundColor: Colors.blueGrey.shade500,
                                onPress: () {
                                  setState(() {
                                    if (productDetailsProvider
                                            .subtotalPriceCalculator() <=
                                        0) {
                                      final snackBar = SnackBar(
                                        backgroundColor: Colors.red.shade500,
                                        content: const Text(
                                            'Unable To Process this Payment.Please Select The minimum one Item'),
                                        action: SnackBarAction(
                                          label: 'Undo',
                                          textColor: Colors.white,
                                          onPressed: () {
                                            // Some code to undo the change.
                                          },
                                        ),
                                      );
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(snackBar);
                                    } else {
                                      productDetailsProvider
                                          .completeBillRecord(context);
                                    }
                                  });
                                },
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: Colors.blueGrey.shade500,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {},
                            child: Row(children: [
                              const Text(
                                "Scan Product",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Icon(
                                Icons.camera_alt_outlined,
                                size: 35,
                                color: Colors.indigo.shade900,
                              )
                            ]),
                          ),
                        ),
                      )
                    ],
                  ),
                  Divider(
                    color: Colors.indigo.shade900,
                    thickness: 1,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Column(
                                children: [
                                  Text(
                                    "Search Your Sellected Item",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.indigo.shade700,
                                    ),
                                  ),
                                  CommonSeachableDrop2(
                                      items: productDetailsProvider
                                          .getAllProductDetailList,
                                      value: productDetailsProvider
                                          .getallProductDetailsModelDataList,
                                      onChanged: (p0) {
                                        setState(() {
                                          productDetailsProvider
                                              .addSelectedProductDetailsModelData(
                                            context,
                                            itemName: p0.itemname,
                                            itemCode: p0.itemcode,
                                            price: p0.unitprice != null
                                                ? p0.unitprice
                                                : 0.00,
                                            discount: p0.discountprice != null
                                                ? p0.discountprice
                                                : 0.00,
                                            totelPrice:
                                                p0.newMarketPrice != null
                                                    ? p0.newMarketPrice
                                                    : p0.unitprice,
                                            qty: "1",
                                          );
                                        });
                                      },
                                      searchController: productDetailsProvider
                                          .getsearchItemController,
                                      controller: productDetailsProvider
                                          .getsearchItemController,
                                      searchMatchFn: (p0, p1) {
                                        return ("${p0.value.companyName!} (${p0.value.itemname}- Rs.${p0.value.newMarketPrice != null ? p0.value.newMarketPrice : p0.value.unitprice} )"
                                            .toLowerCase()
                                            .contains(p1.toLowerCase()));
                                      },
                                      hint: "Search Your Sellected Item"),
                                ],
                              )),
                        ),
                        // SizedBox(
                        //   width: MediaQuery.of(context).size.width / 4,
                        //   child: Padding(
                        //     padding: const EdgeInsets.all(5.0),
                        //     child: Column(
                        //       mainAxisAlignment: MainAxisAlignment.start,
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           "Quantity",
                        //           style: TextStyle(
                        //             fontSize: 16,
                        //             fontWeight: FontWeight.bold,
                        //           ),
                        //         ),
                        //         Row(
                        //           children: [
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(25),
                        //                   color: Colors.green.shade900),
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   productDetailsProvider.incrementQty();
                        //                 },
                        //                 child: Icon(
                        //                   Icons.add,
                        //                   size: 20,
                        //                   color: Colors.grey.shade200,
                        //                 ),
                        //               ),
                        //             ),
                        //             Padding(
                        //               padding: EdgeInsets.all(5.0),
                        //               child:
                        //                   Text("${productDetailsProvider.qty}"),
                        //             ),
                        //             Container(
                        //               decoration: BoxDecoration(
                        //                   borderRadius:
                        //                       BorderRadius.circular(25),
                        //                   color: Colors.redAccent.shade400),
                        //               child: InkWell(
                        //                 onTap: () {
                        //                   productDetailsProvider
                        //                       .decrementQty(context);
                        //                 },
                        //                 child: Icon(
                        //                   Icons.remove,
                        //                   size: 20,
                        //                   color: Colors.grey.shade200,
                        //                 ),
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //         Container(
                        //           padding: EdgeInsets.all(5),
                        //           decoration: BoxDecoration(
                        //               borderRadius: BorderRadius.circular(15),
                        //               color: Colors.indigo.shade500),
                        //           child: Row(
                        //             mainAxisAlignment: MainAxisAlignment.center,
                        //             children: [
                        //               InkWell(
                        //                 onTap: () {},
                        //                 child: Icon(
                        //                   Icons.shopping_cart_rounded,
                        //                   color: Colors.grey.shade200,
                        //                 ),
                        //               ),
                        //             ],
                        //           ),
                        //         )
                        //       ],
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 10, right: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: LinearGradient(
                        colors: [Colors.grey.shade400, Colors.white],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "No Of Itmes:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "${productDetailsProvider.itemCountCalculator()}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Total:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Rs.${NumberFormat('###,000.##').format(productDetailsProvider.calculateTotalPrice())}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.indigo.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Text(
                                  "Discount:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Rs.${NumberFormat('###,000.##').format(productDetailsProvider.calculateDiscountPrice())}",
                                  // "Rs.${productDetailsProvider.calculateDiscountPrice().toStringAsFixed(2)}",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red.shade800,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black54,
                            thickness: 1.5,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Sub Total:",
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green.shade900,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.all(5.0),
                                child: Text(
                                  "Rs.${NumberFormat('###,000.##').format(productDetailsProvider.subtotalPriceCalculator())}",
                                  // "Rs.${productDetailsProvider.subtotalPriceCalculator().toStringAsFixed(2)}",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.green.shade900),
                                ),
                              ),
                            ],
                          ),
                          const Divider(
                            color: Colors.black54,
                            thickness: 1.5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(
                                left: 5, right: 5, bottom: 5, top: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              border: Border(
                                top: BorderSide(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                ),
                                bottom: BorderSide(
                                  color: Colors.grey.shade700,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "Code",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  child: Text(
                                    "Item Name",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 5,
                                  child: Text(
                                    "Qty",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "Price  \n Rs.",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "Discount  \n Rs.",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text(
                                    "Total \n Rs.",
                                    style: TextStyle(
                                      color: Colors.blueGrey.shade900,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Divider(
                            color: Colors.indigo.shade900,
                            thickness: 1,
                          ),
                          if (productDetailsProvider
                              .getselectedProductDetailsModelData.isNotEmpty)
                            for (int i = 0;
                                productDetailsProvider
                                        .getselectedProductDetailsModelData
                                        .length >
                                    i;
                                i++)
                              Container(
                                padding:
                                    const EdgeInsets.only(left: 5, right: 5),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      color: Colors.indigo.shade900,
                                      width: 1,
                                    ),
                                  ),
                                ),
                                child: InkWell(
                                  onTap: () {
                                    productDetailsProvider.updateQtyForItem(
                                        "${productDetailsProvider.getselectedProductDetailsModelData[i].no}",
                                        "${productDetailsProvider.getselectedProductDetailsModelData[i].qty}");
                                  },
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Text(
                                            "${productDetailsProvider.getselectedProductDetailsModelData[i].no}"
                                                .replaceAll("ProduCode-", "")),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                2.5,
                                        child: Text(
                                            "${productDetailsProvider.getselectedProductDetailsModelData[i].itemName}"),
                                      ),
                                      SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              5,
                                          child: SingleChildScrollView(
                                            scrollDirection: Axis.vertical,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(5.0),
                                                  child: Text(
                                                      "${productDetailsProvider.getselectedProductDetailsModelData[i].qty}"),
                                                ),
                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               25),
                                                //       color:
                                                //           Colors.green.shade900),
                                                //   child: InkWell(
                                                //     onTap: () {
                                                //       // productDetailsProvider
                                                //       //     .incrementQty(
                                                //       //         count:
                                                //       //             "${productDetailsProvider.getselectedProductDetailsModelData[i].qty}");
                                                //     },
                                                //     child: Icon(
                                                //       Icons.add,
                                                //       size: 20,
                                                //       color: Colors.grey.shade200,
                                                //     ),
                                                //   ),
                                                // ),

                                                // Container(
                                                //   decoration: BoxDecoration(
                                                //       borderRadius:
                                                //           BorderRadius.circular(
                                                //               25),
                                                //       color: Colors
                                                //           .redAccent.shade400),
                                                //   child: InkWell(
                                                //     onTap: () {
                                                //       productDetailsProvider
                                                //           .decrementQty(context);
                                                //     },
                                                //     child: Icon(
                                                //       Icons.remove,
                                                //       size: 20,
                                                //       color: Colors.grey.shade200,
                                                //     ),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          )),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                6,
                                        child: Text(
                                            "${productDetailsProvider.getselectedProductDetailsModelData[i].price}"),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35),
                                          child: Text(
                                            "${productDetailsProvider.getselectedProductDetailsModelData[i].discount}",
                                            style: TextStyle(
                                              color: Colors.blueGrey.shade900,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                4,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 35),
                                          child: Text(
                                              "${productDetailsProvider.getselectedProductDetailsModelData[i].totelPrice}"),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              color: Colors.green.shade50),
                                          child: InkWell(
                                            onTap: () {
                                              productDetailsProvider
                                                  .removeaddItemRecords(
                                                      productDetailsProvider
                                                          .getselectedProductDetailsModelData[i]);
                                            },
                                            child: Icon(
                                              Icons.delete,
                                              color: Colors.redAccent.shade400,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ));
  }
}
