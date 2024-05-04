// ignore_for_file: file_names
import 'package:flutter/material.dart';

String imageStr = "";
String imageName = "";
String long = "";
String lat = "";
List<String> qIdsList = [];
List<String> fullResult = [];
List businessList = [];
List financialList = [];
List geographicList = [];

List<String> businessData = phoneNumberController.text.split(',');

final TextEditingController phoneNumberController = TextEditingController();

List<TextEditingController> textControllersBusiness =
    List.generate(businessList.length, (index) => TextEditingController());
List<TextEditingController> textControllersFinancial =
    List.generate(financialList.length, (index) => TextEditingController());
// List list1 = [...textControllersBusiness, ...businessData];
List answerList = [...textControllersBusiness, ...textControllersFinancial];
List texts = answerList.map((controller) => controller.text).toList();

clearTextInput() async {
  answerList.clear();
  texts.clear();
  businessList = [];
  // financialList = [];
  imageStr = "";
  imageName = "";
  long = "";
  lat = "";

  if (textControllersBusiness.isNotEmpty) {
    try {
      for (int i = 0; i <= textControllersBusiness.length; i++) {
        textControllersBusiness[i].clear();
      }
    } catch (e) {}
  }
  if (textControllersFinancial.isNotEmpty) {
    try {
      for (int j = 0; j <= textControllersFinancial.length; j++) {
        textControllersFinancial[j].clear();
      }
    } catch (e) {}
  }
}
