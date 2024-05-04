import 'dart:async';

import 'package:get/get.dart';
import 'package:wfm/login/view/login_controller.dart';
import '../../services/http_services.dart';

HttpServices httpServices = HttpServices();

class ChatController extends GetxController {
  List chatHistory = [];
  List chatHistoryReversed = [];
  LogInController _logInController = Get.find();
  Timer? timer;

  @override
  void onInit() {
    super.onInit();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (Timer t) => getChat("246", _logInController.user[0].uId.toString()),
    );
    //print("Seconds");
  }

  Future<void> getChat(String userId, String myUserId) async {
    chatHistory = [];
    chatHistoryReversed = [];
    try {
      var response = await httpServices.getChatHistory(userId, myUserId);
      for (var e in response) {
        chatHistory.add(e);
        chatHistoryReversed = chatHistory.reversed.toList();
      }
    } catch (e) {
      print("Catch $e");
    }
    update();
  }

  Future<void> saveChat(String message) async {
    try {
      var response = await httpServices.postSaveChat(message);
      if (response.statusCode == 200) {
        for (var e in response) {
          //print("Response of Save Chat iss ${e.responce}");
        }
      }
    } catch (e) {
      //print("Response of Save Chat Catch $e");
    }
    update();
  }
}
