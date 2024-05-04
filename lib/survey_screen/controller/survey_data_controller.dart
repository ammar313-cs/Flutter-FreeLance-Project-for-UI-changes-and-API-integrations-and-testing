
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wfm/utlis/globalVariables.dart';
import '../../login/view/login_controller.dart';
import 'dart:convert';

class SurveyDataController extends GetxController {
  bool isLoading = false;
  List surveyTabId = [];
  List surveys = [];
  //List geographicList = [];
  var dropDownList;
  var radioButtonList;

  Future<void> getSurveyData(String userId, String productID) async {
    isLoading = true;
    surveyTabId = [];

    try {
      var response = await httpServices.surveyName(userId);
      for (var e in response) {
        if (productID == e.productId.toString()) {
          surveyTabId.add(e.tabId.toString());
        } else {}
      }

      isLoading = false;
      update(); //why call
    } catch (e) {
      isLoading = false;
    }
  }

  Future<void> getQuestions(String surveyId) async {
    businessList = [];
    geographicList = [];
    financialList = [];
    qIdsList = [];

    try {
      print("survey id $surveyId");
      var response = await httpServices.getQuestionsList(surveyId);
      businessList.clear();
      for (var e in response) {
        qIdsList.add(e.id.toString());
        if (e.tabId.toString() == "business") {
          businessList.add(e);
          // qIdsListBusiness.add(e.id.toString());
        } else if (e.tabId.toString() == "geographic") {
          geographicList.add(e);
        } else if (e.tabId.toString() == "financial") {
          financialList.add(e);
          // qIdsListFinancial.add(e.id.toString());
        }
      }
    } catch (e) {
      print(e.toString());
      businessList.clear();
    }
    update();
    // why call
  }

  Future<void> gettype() async {
    try {
      for (int i = 0; i <= businessList.length; i++) {
        if (businessList[i].type == "dropdown") {
          var a = businessList[i].options;
          String result = a.replaceAll(RegExp('"'), ' ');

          dropDownList = (result.split(','));
        } else if (businessList[i].type == "single-select") {
          var b = businessList[i].options;
          String result = b.replaceAll(RegExp('"'), ' ');

          radioButtonList = (result.split(','));
        }
      }
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  Future<void> saveImage(String imgStr, String imgName) async {
    /* fullResult.add(imgStr);
    fullResult.add(imgName);
    await SaveDatatoSharedPref(fullResult);*/
    try {
      var response = await httpServices.postSaveImage(imgStr, imgName);
      if (response.statusCode == 200) {
        for (var e in response) {
          print("in try");
          // await SaveDatatoSharedPref(fullResult);
        }
      }
    } catch (e) {
      print(e);
      print(e.toString());
    }
    update();
  }

  Future<void> sendArray(String json) async {
    /* fullResult.add(imgStr);
    fullResult.add(imgName);
    await SaveDatatoSharedPref(fullResult);*/
    try {
      var response = await httpServices.postJsonArray(json);
      if (response.statusCode == 200) {
        for (var e in response) {
          print("in try");
          // await SaveDatatoSharedPref(fullResult);
        }
      }
    } catch (e) {
      print(e);
      print(e.toString());
    }
    update();
  }

  Future<void> updateLocation(String uId, String lat, String long) async {
    fullResult.add(lat);
    fullResult.add(long);
    try {
      var response = await httpServices.postUpdateLocation(uId, lat, long);
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  Future<void> saveResult(String surveyId, List qIdList, List answer,
      String uId, String companyId, BuildContext context) async {
    /*   fullResult.add(surveyId);
    var _qIdList = json.encode(qIdList);
    fullResult.add(_qIdList);
    var _answer = json.encode(answer);
    fullResult.add(_answer);
    fullResult.add(companyId);
    fullResult.add(surveyId);*/

    print("Texts $answer");
    try {
      //  checkListItems(context); why i use here

      var response = await httpServices.postSaveResult(
          surveyId, qIdList, answer, uId, companyId);
    } catch (e) {
      print(e.toString());
    }
    update();
  }

  Future<void> SaveDatatoSharedPref(List<String> fullResult) async {
    final prefs = await SharedPreferences.getInstance();

    /*full result of 1 survey completed*/
    List<dynamic> localSaved = [];
    localSaved.add(fullResult);
    var ItemResult = json.encode(localSaved);
    await prefs.setString('ItemResult', ItemResult);
    final String? action = prefs.getString('ItemResult');

    List<dynamic> fullResultReopen = json.decode(action!);
    fullResultReopen.elementAt(1);
    fullResultReopen.length;
  }

  Future<bool> checkListItems(BuildContext context) async {
    if (surveyTabId.contains("business"))
      for (int i = 0; i < textControllersBusiness.length; i++) {
        if (textControllersBusiness[i].text == "") {
          createSnackBar(context, businessList[i].text);
          return false;
        } else {
          businessList[i].answerIs = textControllersBusiness[i].text;
        }
      }

/*financial*/
    if (surveyTabId.contains("financial"))
      for (int i = 0; i < textControllersFinancial.length; i++) {
        if (textControllersFinancial[i].text == "") {
          createSnackBar(context, financialList[i].text);
          return false;
        } else {
          {
            financialList[i].answerIs = textControllersFinancial[i].text;
          }
        }
      }
    if (surveyTabId.contains("geographic")) {
      if (geographicList.map((item) => item.type).contains("file") &&
          imageStr.isEmpty) {
        createSnackBar(context, 'Please add image');
        return false;
      }
    }
    return true;
    SavedatatoList();
  }
}

void SavedatatoList() async {
  /*convert list ot string*/
  var s = json.encode(businessList);
  /*decode conform string list to List back*/
  List businessList_ = json.decode(s);
  businessList_.length;

  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('encodeList', s);

  final String? action = prefs.getString('encodeList');

  List businessListDecode_ = json.decode(action!);
  businessListDecode_.length;
}

void createSnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(
      content: Text("Please fill $message"), backgroundColor: Colors.red);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
