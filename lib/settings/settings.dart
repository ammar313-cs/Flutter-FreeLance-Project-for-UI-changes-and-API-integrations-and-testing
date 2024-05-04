import 'dart:convert';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:wfm/home_screen/view/home_screen.dart';
import 'package:wfm/survey_screen/model/server_model.dart';
import 'package:wfm/utlis/globalVariables.dart';

import '../db/survey_db.dart';
import '../survey_screen/controller/survey_data_controller.dart';
import '../survey_screen/model/survey_model.dart';
import '../survey_screen/model/survey_questions_model.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

enum Minutes {
  two,
  five,
  ten,
}

class _SettingsState extends State<Settings> {
  Minutes? minutesShow = Minutes.two;
  int minutesSelect = 2;
  bool isLoading = false;
  bool isLoadingDialog = false;

  refresh() {
    setState(() {});
  }

  openDialog(BuildContext context) => showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
            builder: ((context, setState) {
              return AlertDialog(
                titlePadding: const EdgeInsets.all(20),
                title: const Text(
                  "Sync Interval",
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                actions: <Widget>[
                  RadioListTile(
                      title: Text('2 Minutes'),
                      toggleable: true,
                      value: Minutes.two,
                      groupValue: minutesShow,
                      onChanged: (Minutes? newValue) {
                        setState(() {
                          minutesShow = newValue;
                          minutesSelect = 1;
                          print("minutes $minutesShow");
                          refresh();
                        });
                      }),
                  RadioListTile(
                      toggleable: true,
                      title: Text('5 Minutes'),
                      value: Minutes.five,
                      groupValue: minutesShow,
                      onChanged: (Minutes? newValue) {
                        setState(() {
                          minutesShow = newValue;
                          minutesSelect = 10;
                          print("minutes $minutesShow");
                          refresh();
                        });
                      }),
                  RadioListTile(
                      toggleable: true,
                      title: Text('10 Minutes'),
                      value: Minutes.ten,
                      groupValue: minutesShow,
                      onChanged: (Minutes? newValue) {
                        setState(() {
                          minutesShow = newValue;
                          minutesSelect = 15;
                          print("minutes $minutesShow");
                          refresh();
                        });
                      }),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  Center(
                    child: isLoadingDialog
                        ? CircularProgressIndicator()
                        : Container(),
                  ),
                  Row(
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "OK",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (() {
                              setState(() {
                                isLoadingDialog = true;
                              });

                              Future.delayed(Duration(minutes: minutesSelect),
                                  () {
// Here you can write your code
                                isLoadingDialog = false;
                                Navigator.pop(context);
                                setState(() {
                                  getDataFromDb();
                                });
                              });
                            }),
                        ),
                      ),
                      Spacer(),
                      RichText(
                        text: TextSpan(
                          text: "CANCEL",
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = (() {
                              Navigator.pop(context);
                            }),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.01,
                  )
                ],
              );
            }),
          ));

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
        title: const Text("Settings"),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Data Sync",
                style: TextStyle(color: Color(0xff01b0b5), fontSize: 18),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              RichText(
                  text: TextSpan(
                      text: "Sync Interval",
                      style: const TextStyle(fontSize: 20, color: Colors.black),
                      recognizer: TapGestureRecognizer()
                        ..onTap = (() => openDialog(context)))),
              minutesShow == Minutes.two
                  ? const Text(
                      "2 Minutes",
                      style: TextStyle(fontSize: 19, color: Colors.grey),
                    )
                  : (minutesShow == Minutes.five)
                      ? const Text(
                          "5 Minutes",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        )
                      : const Text(
                          "10 Minutes",
                          style: TextStyle(fontSize: 19, color: Colors.grey),
                        ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isLoading = true;
                      });
                      await getDataFromDb();
                    },
                    child: const Text(
                      "Sync Now",
                      style: TextStyle(
                        fontSize: 18,
                        color: Color(0xff01b0b5),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                  const Icon(Icons.sync),
                ],
              ),
              (isLoading)
                  ? Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                        // Center(
                        //   child: CircularProgressIndicator(),
                        // ),
                        SizedBox(
                            height: MediaQuery.of(context).size.height * 0.04),
                      ],
                    )
                  : Container(),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.03,
              ),
              Row(
                children: [
                  const Text(
                    "Download Sub-Accounts",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xff01b0b5),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.12,
                  ),
                  const Icon(Icons.cloud_download_rounded),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getDataFromDb() async {
    print("STARTING.....");
    List<SurveyModel> modelList = await SurveyDatabase.instance.readAllNotes();
    if (modelList.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
      await DecodeData(modelList[0]);
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> DecodeData(SurveyModel modelList) async {
    modelList.long;
    modelList.lat;
    modelList.surveyId;
    modelList.imgStr;
    modelList.imgName;
    modelList.companyId;

    modelList.uid;
    modelList.id;

    List answer_ = json.decode(modelList.answer);
    List qIdList_ = json.decode(modelList.qIdList);
    List financiallist_ = json.decode(modelList.financiallist);
    List businesslist_ = json.decode(modelList.businesslist);
    List geographicList_ = json.decode(modelList.geographicList);

    List dummyAnswers = [];
    List dummyIDs = [];
    List typeNames = [];
    /*get id and answer of business*/
    for (int i = 0; i < businesslist_.length; i++) {
      dummyAnswers.add(businesslist_[i]["answerIs"]);
      dummyIDs.add(businesslist_[i]["id"]);
      typeNames.add(businesslist_[i]["type"]);
    }

    /*get id and answer of finance*/
    for (int i = 0; i < financiallist_.length; i++) {
      dummyAnswers.add(financiallist_[i]["answerIs"]);
      dummyIDs.add(financiallist_[i]["id"]);
      typeNames.add(financiallist_[i]["type"]);
    }
    print(dummyIDs);
    print(dummyAnswers);
    print(typeNames);
    print(modelList.long);
    print(modelList.lat);
    print(modelList.imgStr);
    print(modelList.imgName);
    print(modelList.surveyId);
    print(modelList.companyId);
    print(modelList.uid);
    print(modelList.id);
    /*await sendDataServer(
        modelList, dummyAnswers, dummyIDs, typeNames);*/ //previous method and all stuff
    await madeJsonArray(
        modelList, dummyAnswers, dummyIDs, typeNames, geographicList_);
    //new method here
  }

  Future<void> sendDataServer(SurveyModel modelList, List dummyAnswers,
      List dummyIDs, List typeNames) async {
    SurveyDataController surveyDataController = Get.find();
    await surveyDataController.saveResult(
        modelList.surveyId.toString(),
        dummyIDs,
        // textControllersBusiness.text,
        dummyAnswers,
        modelList.uid.toString(),
        modelList.companyId.toString(),
        context);

    await surveyDataController.updateLocation(
        modelList.uid.toString(), modelList.lat, modelList.long);
    // texts = [];
    print("BEFORE IMAGE ENDING.....");

    if (modelList.imgStr.isNotEmpty)
      await surveyDataController.saveImage(
          //comment 29march
          modelList.imgStr.toString(),
          modelList.imgName
              .toString()); //414 ERROR Because we send base64 long string to server.so server increase the string length

    //remove the first item from db
    await SurveyDatabase.instance.delete(modelList.id); //comment 29march
    setState(() {
      isLoading = false;
    });
    print("ENDING ALL.....");
    await madeJsonArray(
        modelList, dummyIDs, dummyAnswers, typeNames, geographicList);

    //recall the class
    await getDataFromDb(); //comment 29march
    //once send to server remove item from db
  }

  Future<void> madeJsonArray(SurveyModel modelList, List dummyIDs,
      List dummyAnswers, List typeNames, List geographicList_) async {
    SurveyDataController surveyDataController = Get.find();
    List<SurverModel> murverList = <SurverModel>[];
    DateTime now = DateTime.now();

    String formattedDate = DateFormat('HH:mm:ss  dd.MM.yyyy').format(now);
    for (int i = 0; i < dummyIDs.length; i++) {
      SurverModel model = SurverModel(
          survey_id: modelList.surveyId,
          q_id: dummyIDs[i].toString(),
          answer: dummyAnswers[i].toString(),
          cb: modelList.uid,
          q_type: typeNames[i].toString(),
          image_name: '',
          cd: formattedDate,
          file_data: '');

      murverList.add(model);
      // model.toJson();
    }

    for (int j = 0; j < geographicList_.length; j++) {
      if (geographicList_[j]["type"] == "map") {
        SurverModel model = SurverModel(
            survey_id: modelList.surveyId,
            q_id: geographicList_[j]["id"].toString(),
            answer: "${modelList.lat},${modelList.long}",
            cb: modelList.uid,
            q_type: geographicList_[j]["type"],
            image_name: '',
            cd: formattedDate,
            file_data: '');
        murverList.add(model);
      } else {
        if (modelList.imgStr.isNotEmpty) {
          SurverModel model = SurverModel(
              survey_id: modelList.surveyId,
              q_id: geographicList_[j]["id"].toString(),
              answer: "${geographicList_[j]["id"]}_${modelList.imgName}",
              cb: modelList.uid,
              q_type: geographicList_[j]["type"],
              image_name: modelList.imgName,
              cd: formattedDate,
              file_data: modelList.imgStr.toString());
          murverList.add(model);
        }
      }
    }

    var json = await jsonEncode(murverList.map((e) => e.toJson()).toList());
    String jsonTags = await jsonEncode(murverList);
    jsonTags.length;

    //senddatatoserver the json with new api
    await surveyDataController.sendArray(json); //update it

    //after it remove it from local DB below code
    /* await SurveyDatabase.instance.delete(modelList.id); //comment 29march
    setState(() {
      isLoading = false;
    });
    print("ENDING ALL.....");*/

    //after it recall below method
    /* await getDataFromDb();*/
  }
}
