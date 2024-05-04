import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../survey_screen/controller/survey_data_controller.dart';

class CustomDropDown extends StatefulWidget {
  final Function() notifyParent;
  final list;

  CustomDropDown({super.key, required this.notifyParent, required this.list});

  @override
  State<CustomDropDown> createState() => _CustomDropDownState();
}

class _CustomDropDownState extends State<CustomDropDown> {
  SurveyDataController surveyDataController = Get.find();
  String? dropdownvalue;

  @override
  Widget build(BuildContext context) {
    var items = surveyDataController.dropDownList;

    return DropdownButton(
      hint: Text("Please Select"),
      // Initial Value
      value: dropdownvalue,

      icon: const Icon(Icons.keyboard_arrow_down),

      items: items
          .map<DropdownMenuItem<String>>((value) => DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              ))
          .toList(),

      onChanged: (newValue) async {
        setState(() {
          dropdownvalue = newValue.toString();
          widget.list.text = newValue.toString();
          widget.notifyParent();
        });
      },
    );
  }
}
