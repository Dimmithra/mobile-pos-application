import 'package:flutter/material.dart';
import 'package:mobile_pos/providers/bill_provider.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:provider/provider.dart';

import '../../../../providers/product_provider.dart';

class PaymentRecordsScreen extends StatefulWidget {
  const PaymentRecordsScreen({super.key});

  @override
  State<PaymentRecordsScreen> createState() => _PaymentRecordsScreenState();
}

class _PaymentRecordsScreenState extends State<PaymentRecordsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BillProvider>(context, listen: false)
          .getAllBillRecords(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
        title: "My Payment Records",
        body: Consumer<BillProvider>(
          builder: (context, billProvider, child) {
            if (billProvider.loadBillPaymentRecords) {
              return CommonLoader();
            }
            return ListView.builder(
              itemCount: billProvider.getbillRecordsModelData!.data!.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.amber),
                    child: Column(children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SuperMarket"),
                        ],
                      ),
                      Divider(
                        color: Colors.blue.shade900,
                      ),
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${billProvider.getbillRecordsModelData!.data![index].cusName}"),
                          Text(
                              "${billProvider.getbillRecordsModelData!.data![index].cusMobileno}"),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              "${billProvider.getbillRecordsModelData!.data![index].dateTime}"),
                          Text(
                              "${billProvider.getbillRecordsModelData!.data![index].cusEmail}"),
                        ],
                      ),
                      Divider(
                        color: Colors.blue.shade900,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text("Total:")),
                              Text(
                                  "${billProvider.getbillRecordsModelData!.data![index].totalAmount}"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text("Discount:")),
                              Text(
                                  "${billProvider.getbillRecordsModelData!.data![index].tdiscountAmount}"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text("Sub Total:")),
                              Text(
                                  "${billProvider.getbillRecordsModelData!.data![index].subtotal}"),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 4,
                                  child: Text("No Of Items:")),
                              Text(
                                  "${billProvider.getbillRecordsModelData!.data![index].itemcount}"),
                            ],
                          ),
                        ],
                      ),
                      Divider(
                        color: Colors.blue.shade900,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                Row(
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
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Text(
                                              "Code",
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2.5,
                                            child: Text(
                                              "Item Name",
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                5,
                                            child: Text(
                                              "Qty",
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Text(
                                              "Price  \n Rs.",
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
                                            child: Text(
                                              "Discount  \n Rs.",
                                              style: TextStyle(
                                                color: Colors.blueGrey.shade900,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                4,
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
                                  ],
                                )
                              ],
                            )),
                      )
                    ]),
                  ),
                );
              },
            );
          },
        ));
  }
}
