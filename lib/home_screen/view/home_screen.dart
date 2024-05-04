import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:wfm/drawer/drawer.dart';
import 'package:wfm/home_screen/view/homeScreen_Controller.dart';
import 'package:wfm/login/view/login_controller.dart';
import 'package:wfm/services/http_services.dart';
import 'package:wfm/survey_screen/controller/survey_data_controller.dart';
import 'package:wfm/survey_screen/survey.dart';
import 'package:wfm/home_screen/view/exit_popup.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    HomeScreenController _homeScreenController =
        Get.put(HomeScreenController());

    super.initState();
  }

  bool isLoading = false;
  SurveyDataController surveyDataController = Get.put(SurveyDataController());
  HomeScreenController homeScreenController = Get.find();
  HttpServices httpServices = HttpServices();

  LogInController _logInController = Get.find();

  @override
  Widget build(BuildContext context) {
    var decodedImage = base64Decode(_logInController.user[0].companyLogo);
    var survey;
    // print("Image Hai ye ${_logInController.user[0].companyLogo.toString()}");
    return WillPopScope(
      onWillPop: () => showExitPopup(context),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0xff01b0b5),
          title: const Text("WFM Field Work"),
        ),
        drawer: CustomDrawer(),
        body: SafeArea(
          child: Container(
            padding: const EdgeInsets.all(10),
            //constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Main New BG.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(18.0),
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Image.memory(
                    decodedImage,
                    fit: BoxFit.fill,
                  ),
                ),
                Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  (isLoading)
                      ? Column(
                          children: [
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                            Center(
                              child: CircularProgressIndicator(),
                            ),
                            SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.04),
                          ],
                        )
                      : Container(),
                ]),
                Expanded(
                  child: GetBuilder<HomeScreenController>(
                    builder: (controller) {
                      return controller.surveyName.isEmpty
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : ListView.separated(
                              itemBuilder: ((context, index) {
                                return GestureDetector(
                                  onTap: () async {
                                    setState(() {
                                      isLoading = true;
                                    });
                                    await myAsyncMethod(context, index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                      homeScreenController.surveyName[index]
                                          .toString(),
                                      style: const TextStyle(fontSize: 24),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }),
                              separatorBuilder: (context, index) {
                                return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.01,
                                );
                              },
                              itemCount:
                                  homeScreenController.surveyName.length);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> myAsyncMethod(BuildContext context, int index) async {
    await surveyDataController.getSurveyData(
        _logInController.user[0].uId.toString(),
        homeScreenController.surveyID[index].toString());
    await surveyDataController.getQuestions(
      homeScreenController.surveyID[index].toString(),
    );
    await surveyDataController.gettype();
    await sendData(context, index);
    setState(() {
      isLoading = false;
    });
  }

  Future<void> sendData(BuildContext context, int index) async {
    await Future.delayed(const Duration(seconds: 3)); //mim comment

    if (!context.mounted) return;
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Survey(
            productName: homeScreenController.surveyName[index].toString(),
            productID: homeScreenController.surveyID[index].toString()),
      ),
    );
  }
}
