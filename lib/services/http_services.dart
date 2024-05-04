// ignore_for_file: unused_local_variable

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:wfm/chat/Chat%20Model/getChatHistory_model.dart';
import 'package:wfm/home_screen/view/home_screen.dart';
import 'package:wfm/submitted_data/model/get_submitted_data_model.dart';
import 'package:wfm/survey_screen/model/survey_questions_model.dart';
import 'package:wfm/utlis/globalVariables.dart';
import '../login/view/login_model.dart';
import '../home_screen/view/homeScreen_Model.dart';

class HttpServices {
  final dio = Dio();
  static const baseURL = "https://copsdev.ufone.com/WFMFieldWork/api/";

  Future<List<LogInModel>> logInUser(String userName, String password) async {
    const url = "${baseURL}GetLogin?";
    print("data in login $userName $password");
    final response = await dio.get(url, queryParameters: {
      "UserName": userName.toString(),
      "Password": password.toString()
    });

    List<LogInModel> userData = [];
    // ...

    List<LogInModel> userDataScreen = [];
    List<LogInterceptor> userDisplay = [];

// ...
    if (response.statusCode == 200) {
      final data = (response.data);
      print("login response ${data.toString()}");
      data.forEach((user) {
        userData.add(LogInModel.fromJson(user));
      });

      if (userData[0].uId != null) {
        print("login response ${response.toString()}");
        Get.to(() => HomeScreen());
      } else if (userData[0].uId == null) {
        print("login response ${response.toString()}");
        Get.showSnackbar(const GetSnackBar(
          duration: Duration(seconds: 3),
          message: "Invalid Credentials",
        ));
      }
      print("data ${userData[0].username}");
      return userData;
    } else {
      print("login response ${response.toString()}");
      throw response.statusCode.toString();
    }
  }

  Future<List<HomeScreenModel>> surveyName(String user_Id) async {
    const url = "${baseURL}getSubProducts?";
    final response = await dio.get(url, queryParameters: {
      "user_id": "278",
    });

    List<HomeScreenModel> surveyData = [];
    if (user_Id != null) {
      final data = (response.data);
      data.forEach((user) {
        surveyData.add(HomeScreenModel.fromJson(user));
      });
      return surveyData;
    } else {
      throw response.statusCode.toString();
    }
  }

  Future<List<GetQuestionsSubmittedModel>> getQuestionsSubmitted(
      userID, startDate, endDate) async {
    const url = "${baseURL}GetQuestionsSubmitted?";
    List<GetQuestionsSubmittedModel> chatHistory = [];
    final response = await dio.get(url, queryParameters: {
      "userid": userID,
      // "userid": '289',
      "start_date": startDate,
      "end_date": endDate,
    });
    if (response.statusCode == 200) {
      response.data.forEach((data) {
        chatHistory.add(GetQuestionsSubmittedModel.fromJson(data));
      });

      return chatHistory;
    } else {
      throw response.statusCode.toString();
    }
  }

  Future<List<GetChatHistoryModel>> getChatHistory(userID, myUserId) async {
    const url = "${baseURL}get_chat_history?";
    List<GetChatHistoryModel> chatHistoryModel = [];
    final response = await dio.get(url, queryParameters: {
      "user_id": '246',
      "my_user_id": '296',
    });
    if (response.statusCode == 200) {
      response.data.forEach((chat) {
        chatHistoryModel.add(GetChatHistoryModel.fromJson(chat));
      });
      for (int i = 0; i < chatHistoryModel.length; i++) {
        // print("Chat History ${chatHistoryModel[i].messages}");
      }
      return chatHistoryModel;
    } else {
      throw response.statusCode.toString();
    }
  }

  Future<List<SurveyQuestionsModel>> getQuestionsList(surveyId) async {
    const url = "${baseURL}get_all_questionsList?";
    List<SurveyQuestionsModel> surveyQuestionsModel = [];
    final response = await dio.get(url, queryParameters: {
      "survey_id": surveyId,
    });
    if (response.statusCode == 200) {
      response.data.forEach((chat) {
        surveyQuestionsModel.add(SurveyQuestionsModel.fromJson(chat));
      });
      return surveyQuestionsModel;
    } else {
      throw response.statusCode.toString();
    }
  }

  Future logoutUser(userID) async {
    const url = "${baseURL}UpdateLogout?";
    print("User ID: $userID");
    final response = await dio.post(url, queryParameters: {
      "user_id": userID,
    });
    if (response.statusCode == 200) {
      print("logout...$response");
    } else {
      throw response.statusCode.toString();
    }
  }

  Future postSaveChat(String message) async {
    const url = "${baseURL}save_chat?";
    // print("User ID: $userID");
    final response = await dio.post(url, queryParameters: {
      "user_id": 246,
      "my_user_id": 296,
      "message": message,
    });
    if (response.statusCode == 200) {
      print("Save Chat...$response");
    } else {
      throw response.statusCode.toString();
    }
  }

  Future postSaveImage(String imgString, String imgName) async {
    const url = "${baseURL}SaveImage?";

    final response = await dio.post(url, queryParameters: {
      "ImgStr": imgString,
      "ImgName": imgName,
    });
    if (response.statusCode == 200) {
      print("Saved Image");
    } else {
      print("in else");
      throw response.statusCode.toString();
    }
  }

  Future postUpdateLocation(String uId, String lat, String long) async {
    const url = "${baseURL}update_location_in_database?";
    String location = "$lat,$long";
    final response = await dio.post(url, queryParameters: {
      "user_id": uId,
      "latlng": location,
    });
    if (response.statusCode == 200) {
      print("Update Location: $response");
    } else {
      throw response.statusCode.toString();
    }
  }

  Future postSaveResult(
    String surveyId,
    List qId,
    List answer,
    String uId,
    String companyId,
  ) async {
    const url = "${baseURL}saveResult?";
    print("Question Id List $qIdsList");
    final response = await dio.post(url, queryParameters: {
      "msisdn": "",
      "survey_id": surveyId,
      "qid": qId,
      "answer": answer,
      "uid": uId,
      "company_id": companyId,
    });
    if (response.statusCode == 200) {
      print("Save Result: $response");
      // textControllersBusiness = [];

      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        message: "Data Submitted!",
      ));
    } else {
      throw response.statusCode.toString();
    }
  }

  Future postJsonArray(
    String json,
  ) async {
    const url = "${baseURL}answersSave?";
    // print("Question Id List $qIdsList");
    final response = await dio.post(url, queryParameters: {
      "data": json,
    });
    if (response.statusCode == 200) {
      print("Save Result: $response");
      // textControllersBusiness = [];

      Get.showSnackbar(const GetSnackBar(
        duration: Duration(seconds: 2),
        message: "Data Submitted!",
      ));
    } else {
      throw response.statusCode.toString();
    }
  }
}
