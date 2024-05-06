import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mobile_pos/model/bill_records_model.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'dart:developer' as dev;
import 'package:http/http.dart' as http;
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/utils/url.dart';

class BillProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  TextEditingController searchItemController = TextEditingController();
  TextEditingController get getsearchItemController => searchItemController;

  Future<void> getAllBillRecords(context) async {
    var email = await storage.read(key: kEmail);
    var mobileNo = await storage.read(key: kmobileNo);
    // var deviceMake = await storage.read(key: kDeviceMake);
    setloadBillPaymentRecords(true);
    try {
      var reqBody = {
        "bill_no": "",
        "cus_email": email,
        "cus_mobileno": mobileNo
      };
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetbillRecord),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );

      BillRecordsModel temp =
          BillRecordsModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);
      if (temp.success == "success") {
        setbillRecordsModelData(temp);

        // setitemData(temp);
      } else {
        commonMessage(context, errorTxt: temp.message.toString()).show();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadBillPaymentRecords(false);
    }
  }

  bool loadBillPaymentRecords = false;
  bool get getloadBillPaymentRecords => loadBillPaymentRecords;
  setloadBillPaymentRecords(val) {
    loadBillPaymentRecords = val;
    notifyListeners();
  }

  BillRecordsModel? billRecordsModelData;
  BillRecordsModel? get getbillRecordsModelData => billRecordsModelData;
  setbillRecordsModelData(val) {
    billRecordsModelData = val;
    notifyListeners();
  }

  Data? itemData;
  Data? get getitemData => itemData;
  setitemData(val) {
    itemData = val;
    notifyListeners();
  }
}
