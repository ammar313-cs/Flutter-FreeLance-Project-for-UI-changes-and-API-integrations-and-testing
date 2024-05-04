import 'package:get/get.dart';
import '../../services/http_services.dart';

HttpServices httpServices = HttpServices();

class LogInController extends GetxController {
  bool isLoading = false;
  List user = [];

  Future<void> getUserData(String userName, String password) async {
    isLoading = true;

    user = [];
    try {
      var response = await httpServices.logInUser(userName, password);
      for (var e in response) {
        user.add(e);
      }
      print("$userName & $password");
      isLoading = false;
      print("data ${user[0].username}");
      update();
    } catch (e) {
      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 3),
        message: "Invalid Credentials login",
      ));
      isLoading = false;
    }
    update();
  }
}
