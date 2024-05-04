// ignore_for_file: file_names

import 'package:get/get.dart';
import '../../login/view/login_controller.dart';
import '../../services/http_services.dart';

HttpServices httpServices = HttpServices();

class HomeScreenController extends GetxController {
  bool isLoading = false;
  List<String> surveyDat = [];
  List<String> surveyID = [];
  List<String> surveyName = [];
  final LogInController _logInController = Get.find();
  @override
  void onInit() {
    getSurveyName(_logInController.user[0].uId.toString());
    super.onInit();
  }

  Future<void> getSurveyName(String userId) async {
    isLoading = true;
    surveyID = [];
    surveyName = [];
    var survey = "";
    try {
      var response = await httpServices.surveyName(userId);
      for (var e in response) {
        if (survey == "") {
          survey = e.productName.toString();
          surveyName.add(survey.toString());
          surveyID.add(e.productId.toString());
        } else if (survey != e.productName.toString()) {
          survey = e.productName.toString();
          surveyName.add(survey.toString());
          surveyID.add(e.productId.toString());
        }
      }
      // print("ye IDs hain all over $surveyID");
      print("ye IDs hain all over $surveyID");
      print("ye IDs hain all over $surveyName");
      print("ye IDs hain all over $survey");
      isLoading = false;
      update();
    } catch (e) {
      isLoading = false;
    }
    update();
  }
}
