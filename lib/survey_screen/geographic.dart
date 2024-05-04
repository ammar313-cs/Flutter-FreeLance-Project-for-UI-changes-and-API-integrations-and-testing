import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
import 'package:get/get.dart';
import 'package:wfm/utlis/globalVariables.dart';
import 'package:wfm/utlis/image_picker.dart';
import 'package:wfm/utlis/location.dart';
import '../utlis/globalVariables.dart';
import 'controller/survey_data_controller.dart';
import 'package:location/location.dart';

class Geographic extends StatefulWidget {
  const Geographic({Key? key}) : super(key: key);

  @override
  State<Geographic> createState() => _GeographicState();
}

class _GeographicState extends State<Geographic> {
  SurveyDataController surveyDataController = Get.find();

  refresh() {
    setState(() {});
    print("refresh is called");
  }

  @override
  Widget build(BuildContext context) {
    return ExpandableNotifier(
        child: Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
        clipBehavior: Clip.antiAlias,
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
                    child: Text("Geographic",
                        style: TextStyle(
                          fontSize: 17,
                        ))),
                collapsed: const SizedBox(),
                expanded:
                    GetBuilder<SurveyDataController>(builder: (controller) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      for (var index in Iterable.generate(
                          geographicList.length))
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
                                    geographicList[index].instructions
                                        .toString(),
                                    softWrap: true,
                                    overflow: TextOverflow.fade,
                                  ),
                                ),
                                Text(
                                  geographicList[index].text,
                                  style: const TextStyle(fontSize: 18),
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.fade,
                                ),
                                if (geographicList[index].type ==
                                    "file")
                                  CustomImagePicker(
                                    notifyParent: refresh,
                                  )
                                else if (geographicList[index].type ==
                                    "map")
                                  const CustomLocation()
                                else
                                  const SizedBox(),
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
