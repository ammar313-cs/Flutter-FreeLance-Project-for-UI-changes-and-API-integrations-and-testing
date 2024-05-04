import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:wfm/utlis/globalVariables.dart';

import 'controller/survey_data_controller.dart';

class Financial extends StatefulWidget {
  Financial({Key? key}) : super(key: key);

  @override
  State<Financial> createState() => _FinancialState();
}

class _FinancialState extends State<Financial> {
  SurveyDataController surveyDataController = Get.find();



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
                    child: Text("Financial",
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
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          for (var index
                              in Iterable.generate(financialList.length))
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
                                        financialList[index]
                                            .instructions
                                            .toString(),
                                        softWrap: true,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                    Text(
                                      financialList[index].id.toString(),
                                      style: const TextStyle(fontSize: 18),
                                    ),
                                    Text(
                                      financialList[index].text,
                                      style: const TextStyle(fontSize: 18),
                                      textAlign: TextAlign.start,
                                      softWrap: true,
                                      overflow: TextOverflow.fade,
                                    ),
                                    TextFormField(
                                      controller:
                                          textControllersFinancial[index],
                                      maxLines: 5,
                                      maxLength: 250,
                                      cursorColor: Colors.grey.shade500,
                                      decoration: const InputDecoration(
                                          focusColor: Colors.white,
                                          enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.black)),
                                          hintText: "(Max 250 characters)"),
                                    ),
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
