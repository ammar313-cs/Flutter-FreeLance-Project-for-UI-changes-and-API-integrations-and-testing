import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wfm/chat/chat.dart';
import 'package:wfm/home_screen/view/home_screen.dart';
import 'package:wfm/login/view/login_screen.dart';
import 'package:wfm/settings/settings.dart';
import 'package:wfm/survey_screen/survey.dart';

import 'home_screen/view/homeScreen_Controller.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'WFM',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: LoginScreen(),
    );
  }
}
