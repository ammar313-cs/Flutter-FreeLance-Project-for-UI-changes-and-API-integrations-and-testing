import 'dart:io';
import 'package:flutter/material.dart';

Future<bool> showExitPopup(context) async {
  return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SizedBox(
            height: MediaQuery.of(context).size.height * 0.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Do you want to exit?"),
                SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          exit(0);
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
}
