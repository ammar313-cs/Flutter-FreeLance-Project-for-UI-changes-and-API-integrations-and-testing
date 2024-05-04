// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../services/http_services.dart';

HttpServices httpServices = HttpServices();

class LogoutController extends GetxController {
  Future<void> logOut(String userId) async {
    try {
      var response = await httpServices.logoutUser(userId);
      if (response.statusCode == 200) {
        for (var e in response) {
          print("Response of Logout ${e.responce}");
        }
      }
    } catch (e) {
      print("Response of Logout Catch $e");
    }
    update();
  }
}
