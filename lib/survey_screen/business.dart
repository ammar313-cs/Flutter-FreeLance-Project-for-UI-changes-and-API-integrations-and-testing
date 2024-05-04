import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:wfm/survey_screen/survey.dart';
import 'package:wfm/utlis/drop_down.dart';
import 'package:wfm/utlis/globalVariables.dart';
import 'package:wfm/utlis/radio_button.dart';
import '../utlis/custom_textformfield.dart';
import 'controller/survey_data_controller.dart';

class Business extends StatefulWidget {
  Business({Key? key}) : super(key: key);

  @override
  State<Business> createState() => _BusinessState();
}

class _BusinessState extends State<Business> {
  SurveyDataController surveyDataController = Get.find();
  int val = 0;
  List questionsList = [];
  List<TextEditingController> _controller = [];

  @override
  void initState() {
    super.initState();
    //refresh();
    textControllersBusiness.clear();
    /*for (int i = 0; i < businessList.length; i++)
      textControllersBusiness.add(TextEditingController());*/
     textControllersBusiness =
         List.generate(businessList.length, (index) => TextEditingController());
    print("it is clicked");
  }

  refresh() {
    setState(() {});
    Survey.listIs.add('value2');
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        child: Column(
          children: <Widget>[
            ScrollOnExpand(
              scrollOnExpand: true,
              scrollOnCollapse: false,
              child: ExpandablePanel(
                theme: const ExpandableThemeData(
                  headerAlignment: ExpandablePanelHeaderAlignment.center,
                  tapBodyToCollapse: true,
                ),
                header: const Padding(
                    padding: EdgeInsets.all(10),
                    child: Text("Business",
                        style: TextStyle(
                          fontSize: 17,
                        ))),
                collapsed: const SizedBox(),
                expanded: FutureBuilder<SurveyDataController>(
                    future: null,
                    builder: (
                      BuildContext context,
                      controller,
                    ) {
                      /*
                          * List<TextEditingController> textControllersBusiness =
                          List.generate(businessList.length,
                                  (index) => TextEditingController());
                          *
                          * */
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var index
                              in Iterable.generate(businessList!.length))
                            Padding(
                                padding: EdgeInsets.only(bottom: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: Colors.grey[300],
                                        borderRadius: BorderRadius.circular(3),
                                      ),
                                      child: Text(
                                        businessList[index]
                                            .instructions
                                            .toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Text(
                                      businessList[index].id.toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      businessList[index].text.toString(),
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                    businessList[index].type ==
                                            "text-field-large"
                                        ? CustomLargeTextFormField(
                                            largeTextFieldController:
                                                // _controller[index],
                                                textControllersBusiness[index],
                                            businessList: businessList[index],
                                          )
                                        : businessList[index].type == "numeric"
                                            ? CustomPhoneNumberTextFormField(
                                                phoneNumberController:
                                                    textControllersBusiness[
                                                        index])
                                            : businessList[index].type ==
                                                    "single-select"
                                                ? CustomRadioButton(
                                                    list:
                                                        textControllersBusiness[
                                                            index])
                                                : businessList[index].type ==
                                                        "dropdown"
                                                    ? CustomDropDown(
                                                        notifyParent: refresh,
                                                        list:
                                                            textControllersBusiness[
                                                                index])
                                                    : SizedBox(),
                                  ],
                                )),
                        ],
                      );
                    }),
                builder: (index, collapsed, expanded) {
                  return Padding(
                    padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                    child: Expandable(
                      collapsed: collapsed,
                      expanded: expanded,
                      theme: const ExpandableThemeData(crossFadePoint: 0),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
