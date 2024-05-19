import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/product_provider.dart';
import 'package:mobile_pos/screens/main_home/dashboard/bill_payment_screen/bill_payment.dart';
import 'package:mobile_pos/widget/common_btn.dart';
import 'package:provider/provider.dart';

class QrResultScreen extends StatefulWidget {
  const QrResultScreen({
    super.key,
    required this.dataMap,
  });
  final Map<String, String> dataMap;

  @override
  State<QrResultScreen> createState() => _QrResultScreenState();
}

class _QrResultScreenState extends State<QrResultScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Result"),
      ),
      body: Consumer<ProductDetailsProvider>(
        builder: (context, productDetailsProvider, child) {
          return Container(
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: ListView(
                    children: widget.dataMap.entries.map((entry) {
                      return buildTextField(entry.key, entry.value);
                    }).toList(),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 1.4,
                        left: 8,
                        right: 8),
                    child: Column(
                      children: [
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(25),
                        //           color: Colors.green.shade900),
                        //       child: InkWell(
                        //         onTap: () {
                        //           productDetailsProvider.incrementQty();
                        //         },
                        //         child: Icon(
                        //           Icons.add,
                        //           size: 30,
                        //           color: Colors.grey.shade200,
                        //         ),
                        //       ),
                        //     ),
                        //     Padding(
                        //       padding: EdgeInsets.all(5.0),
                        //       child: Text("${productDetailsProvider.qty}"),
                        //     ),
                        //     Container(
                        //       decoration: BoxDecoration(
                        //           borderRadius: BorderRadius.circular(25),
                        //           color: Colors.redAccent.shade400),
                        //       child: InkWell(
                        //         onTap: () {
                        //           productDetailsProvider.decrementQty(context);
                        //         },
                        //         child: Icon(
                        //           Icons.remove,
                        //           size: 30,
                        //           color: Colors.grey.shade200,
                        //         ),
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CommonBtn(
                                backgroundColor: Colors.red,
                                bntName: "Close",
                                onPress: () {},
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CommonBtn(
                                bntName: "Save",
                                onPress: () {
                                  // if (productDetailsProvider.qty > 0) {
                                  productDetailsProvider
                                      .addSelectedProductDetailsModelData(
                                          context,
                                          itemName: widget.dataMap['Product'],
                                          itemCode: widget.dataMap['Code'],
                                          price: widget.dataMap['MPrice'],
                                          discount:
                                              widget.dataMap['DPrice'] == ""
                                                  ? "0"
                                                  : widget.dataMap['DPrice'],
                                          totelPrice:
                                              widget.dataMap['sPrice'] == ""
                                                  ? widget.dataMap['MPrice']
                                                  : widget.dataMap['sPrice'],
                                          qty: "1"
                                          // productDetailsProvider.qty.toString(),
                                          );
                                  print("Length ${widget.dataMap['sPrice']}");
                                  Navigator.pushAndRemoveUntil(context,
                                      MaterialPageRoute(
                                    builder: (context) {
                                      return BillPaymentScreen();
                                    },
                                  ), (route) => false);
                                  // }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
    );
  }

  Widget buildTextField(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: label,
                border: OutlineInputBorder(),
              ),
              controller: TextEditingController(text: value),
              readOnly: true,
            ),
          ],
        ),
      ),
    );
  }

  // double totalPrice() {
  //   var productProvider =
  //       Provider.of<ProductDetailsProvider>(context, listen: false);

  //   String totalAmount =
  //       widget.dataMap['MPrice'].toString() * productProvider.qty.toInt();
  // }

  // double itemCount = 0;
  // double itemCountCalculator() {
  //   var productProvider =
  //       Provider.of<ProductDetailsProvider>(context, listen: false);

  //   double itemCount = productProvider.q;
  //   itemCount +=
  //       double.parse(getselectedProductDetailsModelData.length.toString());

  //   return itemCount;
  // }
}
