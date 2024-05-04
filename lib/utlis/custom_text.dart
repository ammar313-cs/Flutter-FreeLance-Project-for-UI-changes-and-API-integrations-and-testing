import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBoldText extends StatelessWidget {
  String text;
  CustomBoldText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
          color: Colors.black, fontSize: 24.0, fontWeight: FontWeight.w400),
    );
  }
}
