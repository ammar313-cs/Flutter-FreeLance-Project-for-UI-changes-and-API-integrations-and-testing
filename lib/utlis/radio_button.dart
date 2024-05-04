import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wfm/survey_screen/controller/survey_data_controller.dart';

enum SingingCharacter { lafayette, jefferson }

class CustomRadioButton extends StatefulWidget {
  final list;

  const CustomRadioButton({super.key, required this.list});

  @override
  State<CustomRadioButton> createState() => _CustomRadioButtonState();
}

class _CustomRadioButtonState extends State<CustomRadioButton> {
  SingingCharacter? _singingCharacter = SingingCharacter.lafayette;
  SurveyDataController _surveyDataController = Get.find();
  String _selectedItem = "";

  List<Widget> _buildRadioListTiles(List<String> items) {
    return items
        .map((item) => RadioListTile(
              title: Text(item),
              value: item,
              groupValue: _selectedItem,
              onChanged: (dynamic value) {
                setState(() {
                  _selectedItem = value;
                  widget.list.text = _selectedItem;
                  print("selected $_selectedItem");
                });
              },
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: _buildRadioListTiles(_surveyDataController.radioButtonList),
    );
  }
}
