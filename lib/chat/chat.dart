import 'package:flutter/material.dart';
import 'package:flutter_chat_list/chat_list.dart';
import 'package:get/get.dart';
import 'package:wfm/chat/Controller/chat_controller.dart';
import '../home_screen/view/home_screen.dart';
import 'package:grouped_list/grouped_list.dart';

class Chat extends StatefulWidget {
  Chat({super.key});

  @override
  State<Chat> createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  clearTextInput() {
    saveChatEditingController.clear();
  }

  final TextEditingController saveChatEditingController =
      TextEditingController();
  ChatController chatController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
        ),
        backgroundColor: const Color(0xff01b0b5),
        title: const Text("Chat with Admin"),
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ChatController>(
              builder: (controller) {
                return controller.chatHistory.isEmpty
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        reverse: true,
                        itemCount: controller.chatHistoryReversed.length,
                        shrinkWrap: true,
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        itemBuilder: (context, index) {
                          return Column(
                            children: [
                              Container(
                                margin: const EdgeInsets.only(
                                    left: 10, top: 5, right: 10, bottom: 5),
                                child: Align(
                                  alignment: (chatController
                                              .chatHistoryReversed[index].cb ==
                                          296
                                      ? Alignment.topLeft
                                      : Alignment.topRight),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: (const Color(0xff01b0b5)),
                                    ),
                                    padding: const EdgeInsets.only(
                                        left: 16,
                                        right: 16,
                                        top: 10,
                                        bottom: 10),
                                    child: Text(
                                      chatController
                                          .chatHistoryReversed[index].messages
                                          .toString(),
                                      style: const TextStyle(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, right: 10),
                                child: Align(
                                  alignment: chatController
                                              .chatHistoryReversed[index].cb ==
                                          296
                                      ? Alignment.topLeft
                                      : Alignment.topRight,
                                  child: Text(
                                    chatController
                                        .chatHistoryReversed[index].dates
                                        .toString(),
                                    style: const TextStyle(
                                      fontSize: 11,
                                    ),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              )
                            ],
                          );
                        },
                      );
              },
            ),
          ),
          Align(
            //alignment: Alignment.center,
            child: Container(
              // margin: EdgeInsets.only(top: 20),
              padding: const EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: MediaQuery.of(context).size.height * 0.08,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: saveChatEditingController,
                      decoration: const InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.1,
                  ),
                  FloatingActionButton(
                    onPressed: () async {
                      chatController.saveChat(saveChatEditingController.text);
                      clearTextInput();
                    },
                    backgroundColor: Color(0xff01b0b5),
                    elevation: 0,
                    child: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
