import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import 'package:wfm/db/survey_db.dart';
import 'package:wfm/home_screen/view/homeScreen_Controller.dart';
import 'package:wfm/login/view/login_controller.dart';
import 'package:wfm/survey_screen/controller/survey_data_controller.dart';
import 'package:wfm/survey_screen/financials.dart';
import 'package:wfm/survey_screen/geographic.dart';
import 'package:wfm/survey_screen/business.dart';
import 'package:wfm/survey_screen/model/survey_model.dart';
import 'package:wfm/utlis/globalVariables.dart';
import '../home_screen/view/home_screen.dart';

class Survey extends StatefulWidget {
  var productName;
  var productID;

  static List<String> listIs = <String>[];

  Survey({Key? key, required this.productName, required this.productID})
      : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController textFieldController = TextEditingController();
  SurveyDataController surveyDataController = Get.find();
  LogInController logInController = Get.find();
  HomeScreenController homeScreenController = Get.find();

  refresh() {
    setState(() {});
  }

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
        title: Text(widget.productName),
      ),
      body: SingleChildScrollView(
        child: GetBuilder<SurveyDataController>(builder: (controller) {
          List<TextEditingController> textControllersBusiness = List.generate(
              businessList.length, (index) => TextEditingController());
          return surveyDataController.surveyTabId.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(
                  children: [
                    controller.surveyTabId.toString().contains("business")
                        ? ExpandableNotifier(child: Business())
                        : const SizedBox(),
                    controller.surveyTabId.toString().contains("geographic")
                        ? ExpandableNotifier(child: const Geographic())
                        : const SizedBox(),
                    controller.surveyTabId.toString().contains("financial")
                        ? ExpandableNotifier(child: Financial())
                        : const SizedBox(),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.91,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isTure = await surveyDataController
                              .checkListItems(context);
                          if (isTure) {
                            await SaveDatatoLocalDB(widget, logInController,
                                texts, refresh(), context);
                          } else {}
                          /* await surveyDataController.saveResult(
                              widget.productID,
                              qIdsList.toList(),
                              // textControllersBusiness.text,
                              texts,
                              logInController.user[0].uId.toString(),
                              logInController.user[0].companyId.toString(),
                              context);

                          await surveyDataController.updateLocation(
                              logInController.user[0].uId.toString(),
                              lat,
                              long);
                          // texts = [];
                          await surveyDataController.saveImage(
                              imageStr, 'image1');
                          Survey.listIs.length;
                          clearTextInput();
                          refresh();*/
                        },
                        child: const Text("SUBMIT",
                            style: TextStyle(fontSize: 20)),
                      ),
                    )
                  ],
                );
        }),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Survey.listIs.add('value');
  }
}

Future<void> SaveDatatoLocalDB(Survey widget, LogInController logInController,
    List texts, refresh, BuildContext context) async {
  var qIdsL = json.encode(qIdsList);
  var answerL = json.encode(texts);
  var businessL = json.encode(businessList);
  var financialL = json.encode(financialList);
  var geologicalL = json.encode(geographicList);

  String surveyId = widget.productID;

  SurveyModel note = SurveyModel(
      surveyId: surveyId,
      qIdList: qIdsL,
      answer: answerL,
      uid: logInController.user[0].uId.toString(),
      companyId: logInController.user[0].companyId.toString(),
      lat: lat,
      long: long,
      imgStr: imageStr,
      imgName: imageName,
      businesslist: businessL,
      financiallist: financialL,
      geographicList: geologicalL);

  await SurveyDatabase.instance.create(note);
  textControllersBusiness.clear();
  // textControllersFinancial.clear();
  await clearTextInput();

  refresh;
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => HomeScreen()));
/*  if (Navigator.canPop(context)) {
    Navigator.pop(context);
  } else {
    SystemNavigator.pop();
  }*/
  /*Read Data*/
  /* List<SurveyModel> model = await SurveyDatabase.instance.readAllNotes();
  model[0].lat;*/
}
