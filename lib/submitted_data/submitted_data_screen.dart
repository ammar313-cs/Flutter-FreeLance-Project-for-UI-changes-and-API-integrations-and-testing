import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:intl/intl.dart';
import 'package:wfm/submitted_data/controller/get_submitted_data_controller.dart';

import '../home_screen/view/home_screen.dart';

class SubmittedData extends StatefulWidget {
  const SubmittedData({super.key});

  @override
  State<SubmittedData> createState() => _SubmittedDataState();
}

class _SubmittedDataState extends State<SubmittedData> {
  GetSubmittedDataController _getSubmittedDataController =
      Get.put(GetSubmittedDataController());
  TextEditingController startDate = new TextEditingController();
  TextEditingController endDate = new TextEditingController();

  @override
  void initState() {
    _getSubmittedDataController.submittedData = [];
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff01b0b5),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: (() {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }),
        ),
        title: const Text("Reports"),
      ),
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
              // image: DecorationImage(
              //   image: AssetImage("assets/Main New BG.png"),
              //   fit: BoxFit.cover,
              // ),
              ),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 3),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.39,
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          if (selectedDate == null) {
                            debugPrint('No Date Selected');
                          }
                          if (selectedDate != null) {
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(selectedDate);

                            setState(() {
                              startDate.text = formattedDate;
                            });
                          }
                        });
                      },
                      controller: startDate,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          focusColor: Colors.white,
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          // hintText: '11/17/2021',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 5),
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.06,
                    width: MediaQuery.of(context).size.width * 0.40,
                    padding: EdgeInsets.symmetric(horizontal: 4),
                    child: TextFormField(
                      readOnly: true,
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2001),
                          lastDate: DateTime.now(),
                        ).then((selectedDate) {
                          if (selectedDate == null) {
                            debugPrint('No Date Selected');
                          }
                          if (selectedDate != null) {
                            String formattedDate =
                                DateFormat('MM/dd/yyyy').format(selectedDate);

                            setState(() {
                              endDate.text = formattedDate;
                            });
                          }
                        });
                      },
                      controller: endDate,
                      cursorColor: Color(0xff01b0b5),
                      keyboardType: TextInputType.number,
                      decoration: const InputDecoration(
                          suffixIcon: Icon(Icons.calendar_month),
                          fillColor: Colors.white,
                          filled: true,
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.grey)),
                          // hintText: '11/17/2021',
                          contentPadding:
                              EdgeInsets.symmetric(vertical: 15, horizontal: 4),
                          hintStyle: TextStyle(color: Colors.black)),
                    ),
                  ),
                  ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all<Color>(Color(0xff01b0b5)),
                        padding:
                            MaterialStateProperty.all(const EdgeInsets.all(5))),
                    onPressed: () async {
                      print("Pressed");
                      await _getSubmittedDataController.getSubmittedData(
                          startDate.text, endDate.text);
                    },
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),
              // Text(
              //     "heloo ${_getSubmittedDataController.submittedData[0].productId}"),

              Expanded(
                child: GetBuilder<GetSubmittedDataController>(
                  builder: (controller) {
                    return
                        //controller.isLoading == true
                        // ? Center(child: CircularProgressIndicator())
                        controller.submittedData.isEmpty
                            ? const Text(
                                "No Record Found.",
                                style: TextStyle(fontSize: 18),
                              )
                            : controller.submittedData.isNotEmpty

                                // controller.isLoading == true
                                ? controller.isLoading == true
                                    ? const Center(
                                        child: CircularProgressIndicator())
                                    : ListView.separated(
                                        itemCount:
                                            controller.submittedData.length,
                                        itemBuilder: ((context, index) {
                                          return Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.02,
                                            margin: EdgeInsets.all(5),
                                            padding: EdgeInsets.all(10),
                                            decoration: const BoxDecoration(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(10)),
                                              color: Color(0xFFffffff),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey,
                                                  blurRadius:
                                                      1.0, // soften the shadow
                                                  spreadRadius:
                                                      1.0, //extend the shadow
                                                  offset: Offset(
                                                    1.0, // Move to right 5  horizontally
                                                    1.0, // Move to bottom 5 Vertically
                                                  ),
                                                )
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text(
                                                        _getSubmittedDataController
                                                            .submittedData[0]
                                                            .productName,
                                                        style: const TextStyle(
                                                            fontSize: 18,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Flexible(
                                                      child: Text(
                                                        _getSubmittedDataController
                                                            .submittedData[0]
                                                            .text,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        overflow:
                                                            TextOverflow.clip,
                                                        softWrap: true,
                                                        maxLines: 5,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text(
                                                      _getSubmittedDataController
                                                          .submittedData[0]
                                                          .answer,
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                SizedBox(
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .height *
                                                      0.05,
                                                ),
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      _getSubmittedDataController
                                                          .submittedData[0]
                                                          .tabId,
                                                    ),
                                                    Text(
                                                        _getSubmittedDataController
                                                            .submittedData[0]
                                                            .cd),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                        separatorBuilder:
                                            (BuildContext context, int index) {
                                          return SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height *
                                                0.01,
                                          );
                                        },
                                      )
                                : const Text("No Record Found.");
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
