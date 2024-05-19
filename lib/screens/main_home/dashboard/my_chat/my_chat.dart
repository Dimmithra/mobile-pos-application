import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mobile_pos/providers/chat_provider.dart';
import 'package:mobile_pos/utils/common_main.dart';
import 'package:mobile_pos/utils/loader.dart';
import 'package:mobile_pos/widget/common_input.dart';
import 'package:provider/provider.dart';

class MyChatScreen extends StatefulWidget {
  const MyChatScreen({super.key});

  @override
  State<MyChatScreen> createState() => _MyChatScreenState();
}

class _MyChatScreenState extends State<MyChatScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ChatProvider>(context, listen: false).scrollToBottomChat();
      Provider.of<ChatProvider>(context, listen: false).removeSendMessages();
      Provider.of<ChatProvider>(context, listen: false).getAllMessages(context);
      Provider.of<ChatProvider>(context, listen: false).clearData();
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<ChatProvider>(context, listen: false)
        .scrollController
        .dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CommonMainScreen(
      title: "My Chat",
      body: Consumer<ChatProvider>(
        builder: (context, chatProvider, child) {
          if (chatProvider.getloadChatData) {
            return CommonLoader();
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  controller: chatProvider.getscrollController,
                  // scrollDirection: Axis.vertical,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (chatProvider
                              .getallMessageResponseData!.data!.length !=
                          null)
                        for (int index = 0;
                            chatProvider
                                    .getallMessageResponseData!.data!.length >
                                index;
                            index++)
                          for (int x = 0;
                              chatProvider.getallMessageResponseData!
                                      .data![index].messages!.length >
                                  x;
                              x++)
                            Padding(
                              padding: EdgeInsets.all(10),
                              child: SizedBox(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        chatProvider.getallMessageResponseData!
                                            .data![index].messages![x].date
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey.shade700,
                                        ),
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment: chatProvider
                                                  .getallMessageResponseData!
                                                  .data![index]
                                                  .messages![x]
                                                  .cusemail ==
                                              chatProvider.uEmail
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      children: [
                                        if (chatProvider
                                                .getallMessageResponseData!
                                                .data![index]
                                                .messages![x]
                                                .cusemail !=
                                            chatProvider.uEmail)
                                          const Icon(
                                            Icons.person_2_rounded,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              chatProvider.showMessageTime =
                                                  true;
                                            });
                                          },
                                          onDoubleTap: () {
                                            chatProvider.showMessageTime =
                                                false;
                                          },
                                          child: SizedBox(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Card(
                                              color: chatProvider
                                                          .getallMessageResponseData!
                                                          .data![index]
                                                          .messages![x]
                                                          .cusemail ==
                                                      chatProvider.uEmail
                                                  ? Colors.blue.shade400
                                                  : Colors.green,
                                              child: Container(
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.end,
                                                    children: [
                                                      Text(
                                                        "${chatProvider.getallMessageResponseData!.data![index].messages![x].message}",
                                                        textAlign:
                                                            TextAlign.start,
                                                        style: TextStyle(
                                                            fontSize: 16,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color:
                                                                Colors.black),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "${chatProvider.getallMessageResponseData!.data![index].messages![x].cusname}",
                                                            style: TextStyle(
                                                                fontSize: 12,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .grey
                                                                    .shade300),
                                                          ),
                                                          Icon(
                                                            Icons.done_all,
                                                            size: 15,
                                                          ),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        if (chatProvider
                                                .getallMessageResponseData!
                                                .data![index]
                                                .messages![x]
                                                .cusemail ==
                                            chatProvider.uEmail)
                                          const Icon(
                                            Icons.person_2_rounded,
                                            size: 20,
                                            color: Colors.black54,
                                          ),
                                      ],
                                    ),
                                    if (chatProvider.showMessageTime)
                                      Row(
                                        mainAxisAlignment: chatProvider
                                                    .uEmail ==
                                                chatProvider
                                                    .getallMessageResponseData!
                                                    .data![index]
                                                    .messages![x]
                                                    .cusemail
                                            ? MainAxisAlignment.end
                                            : MainAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              chatProvider
                                                  .getallMessageResponseData!
                                                  .data![index]
                                                  .messages![x]
                                                  .time
                                                  .toString(),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Colors.grey.shade700,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                  ],
                                ),
                              ),
                            ),
                      for (int i = 0;
                          chatProvider.getmessageSendModelData.length > i;
                          i++)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width / 2,
                              child: Card(
                                color: Colors.blue.shade400,
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Text(
                                          "${chatProvider.getmessageSendModelData[i].message}",
                                          textAlign: TextAlign.justify,
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600,
                                              color: Colors.black),
                                        ),
                                        chatProvider.getmessageResponseModeldata !=
                                                null
                                            ? Icon(
                                                chatProvider.getsentMessageLoader &&
                                                        chatProvider
                                                                .getmessageResponseModeldata!
                                                                .status !=
                                                            "Success"
                                                    ? Icons.pending_outlined
                                                    : Icons.done_all,
                                                size: 15,
                                              )
                                            : SizedBox.shrink()
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const Icon(
                              Icons.person_2_rounded,
                              size: 20,
                              color: Colors.black54,
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: CommonInput(
                        controller: chatProvider.getmessageTextController,
                        hintText: "Enter Your Message",
                        label: "Enter Your Message",
                        fullboader: true,
                        suffix: IconButton(
                            onPressed: () {
                              setState(() {
                                if (chatProvider
                                    .getmessageTextController.text.isNotEmpty) {
                                  chatProvider.setmessageSendModelData(context,
                                      message: chatProvider
                                          .getmessageTextController.text);
                                  chatProvider.sentMessage(context);
                                } else {
                                  final snackBar = SnackBar(
                                    backgroundColor: Colors.red.shade500,
                                    content: const Text(
                                        'Unable To send empty message'),
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
                                }
                              });

                              // chatProvider.sendNewMessage(
                              //     chatProvider.getmessageTextController.text);
                            },
                            icon: Icon(Icons.send)),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
