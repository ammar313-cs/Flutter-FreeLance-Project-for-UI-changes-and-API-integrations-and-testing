import 'package:get/get.dart';
import 'package:wfm/login/view/login_controller.dart';
import 'package:wfm/submitted_data/submitted_data_screen.dart';

class GetSubmittedDataController extends GetxController {
  List submittedData = [];
  LogInController _logInController = Get.find();
  bool isLoading = true;

  Future<void> getSubmittedData(String startDate, String endDate) async {
    submittedData = [];
    try {
      var response = await httpServices.getQuestionsSubmitted(
          _logInController.user[0].uId, startDate, endDate);
      for (var e in response) {
        submittedData.add(e);
      }

      if (submittedData.isNotEmpty) {
        isLoading = false;
        update();
      } else {
        isLoading = true;
        update();
      }
      update();
    } catch (e) {
      isLoading = false;
      update();
    }
    update();
  }
}
