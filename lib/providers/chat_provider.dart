import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pos/model/all_messages_model.dart';
import 'package:mobile_pos/model/message_model.dart';
import 'package:mobile_pos/model/message_send_model.dart';
import 'package:mobile_pos/utils/key_const.dart';
import 'package:mobile_pos/utils/message.dart';
import 'package:mobile_pos/utils/url.dart';
import 'package:http/http.dart' as http;
import 'dart:developer' as dev;

class ChatProvider extends ChangeNotifier {
  final storage = const FlutterSecureStorage();

  TextEditingController messageTextController = TextEditingController();
  TextEditingController get getmessageTextController => messageTextController;

  List<MessageSendModel> messageSendModelData = [];
  List<MessageSendModel> get getmessageSendModelData => messageSendModelData;
  setmessageSendModelData(
    context, {
    // String? name,
    // String? date,
    // String? time,
    // String? email,
    String? message,
  }) {
    var temp = MessageSendModel(
      // name: name,
      // date: date,
      // time: time,
      // email: email,
      message: message.toString(),
    );
    sendNewMessage(temp);
    // notifyListeners();
  }

  sendNewMessage(val) {
    getmessageSendModelData.add(val);
    notifyListeners();
  }

  Future scrollToBottom(ScrollController scrollController) async {
    while (scrollController.position.pixels !=
        scrollController.position.maxScrollExtent) {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
      await SchedulerBinding.instance.endOfFrame;
    }
  }

  removeSendMessages() {
    for (int i = 0; i < getmessageSendModelData.length;) {
      getmessageSendModelData.remove(getmessageSendModelData[i]);
      notifyListeners();
    }
  }

  //get all chat data
  String currentDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String currentTime = DateFormat('hh:mm:ss').format(DateTime.now());
  String uEmail = "";
  Future<void> sentMessage(context) async {
    var userEmail = await storage.read(key: kEmail);
    var usermobileNo = await storage.read(key: kmobileNo);
    var userName = await storage.read(key: kcustomername);
    uEmail = userEmail.toString();
    try {
      setsentMessageLoader(true);
      var reqBody = {
        "messages": [
          {
            "cusemail": userEmail,
            "cusname": userName,
            "message": getmessageTextController.text,
            "date": currentDate,
            "time": currentTime,
          }
        ]
      };
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kmessageSent),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      MessageResponseModel temp =
          MessageResponseModel.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'Success') {
        setmessageResponseModeldata(temp);
        getmessageTextController.clear();
      } else {
        setmessageResponseModeldata(temp);
        commonMessage(context, errorTxt: "${temp.message}").show();
        getmessageTextController.clear();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setsentMessageLoader(false);
    }
  }

  MessageResponseModel? messageResponseModeldata;
  MessageResponseModel? get getmessageResponseModeldata =>
      messageResponseModeldata;
  setmessageResponseModeldata(val) {
    messageResponseModeldata = val;
    notifyListeners();
  }

  bool sentMessageLoader = false;
  bool get getsentMessageLoader => sentMessageLoader;
  setsentMessageLoader(val) {
    sentMessageLoader = val;
    notifyListeners();
  }

  bool loadChatData = false;
  bool get getloadChatData => loadChatData;
  setloadChatData(val) {
    loadChatData = val;
    notifyListeners();
  }

  //get all message

  Future<void> getAllMessages(context) async {
    try {
      setloadChatData(true);
      var reqBody = {};
      dev.log(reqBody.toString());
      var response = await http.post(
        Uri.parse(kgetmessageSent),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(reqBody),
      );
      dev.log(response.body);

      GetAllMessageResponse temp =
          GetAllMessageResponse.fromJson(jsonDecode(response.body));
      dev.log(response.body);

      if (temp.success == 'success') {
        setallMessageResponseData(temp);
      } else {
        setallMessageResponseData(temp);
        commonMessage(context, errorTxt: "${temp.message}").show();
        getmessageTextController.clear();
      }
    } catch (e) {
      dev.log(e.toString());
    } finally {
      setloadChatData(false);
    }
  }

  GetAllMessageResponse? allMessageResponseData;
  GetAllMessageResponse? get getallMessageResponseData =>
      allMessageResponseData;
  setallMessageResponseData(val) {
    allMessageResponseData = val;
    notifyListeners();
  }

  Data? allDataSet;
  Data? get getallDataSet => allDataSet;
  setallDataSet(val) {
    allDataSet = val;
    notifyListeners();
  }

  bool showMessageTime = false;
  bool get getshowMessageTime => showMessageTime;
  setshowMessageTime(val) {
    showMessageTime = val;
    notifyListeners();
  }

  void clearData() async {
    showMessageTime = false;
  }

  final ScrollController scrollController = ScrollController();
  void scrollToBottomChat() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }
}
