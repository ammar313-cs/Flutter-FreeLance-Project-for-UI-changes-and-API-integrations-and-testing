import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:wfm/chat/chat.dart';
import 'package:wfm/drawer/Controller/logout_controller.dart';
import 'package:wfm/login/view/login_screen.dart';
import 'package:wfm/settings/settings.dart';
import 'package:wfm/submitted_data/submitted_data_screen.dart';

import '../chat/Controller/chat_controller.dart';
import '../login/view/login_controller.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({
    Key? key,
  }) : super(key: key);

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  LogInController _logInController = Get.put(LogInController());
  LogoutController logoutController = Get.put(LogoutController());
  ChatController chatController = Get.put(ChatController());

  logoutPopup(BuildContext context) => showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.11,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Are you sure to logout?"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () async {
                          logoutController
                              .logOut(_logInController.user[0].uId.toString());
                          Get.off(LoginScreen());
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff01b0b5)),
                        child: const Text("Yes"),
                      ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.10),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                        ),
                        child: const Text("No",
                            style: TextStyle(color: Colors.black)),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      });
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff01b0b5),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/Logo.png',
                  scale: 3.0,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                Text(
                  "${_logInController.user[0].fullName}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
                Text(
                  "${_logInController.user[0].email}",
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.chat),
            title: const Text('Chat',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 81, 78, 78),
                )),
            onTap: () async {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Chat()));
              await chatController.getChat(
                  "246", _logInController.user[0].uId.toString());
            },
          ),
          ListTile(
            leading: const Icon(Icons.assignment),
            title: const Text('Submitted Data',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 81, 78, 78),
                )),
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SubmittedData()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Settings',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 81, 78, 78),
                )),
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Settings()));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: const Text('Logout',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.0,
                  color: Color.fromARGB(255, 81, 78, 78),
                )),
            onTap: () {
              logoutPopup(context);
            },
          ),
        ],
      ),
    );
  }
}
