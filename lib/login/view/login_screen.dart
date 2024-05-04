import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:wfm/home_screen/view/homeScreen_Controller.dart';
import 'package:wfm/login/view/login_controller.dart';
import 'package:wfm/services/http_services.dart';
import 'package:wfm/utlis/custom_text.dart';
import 'package:wfm/utlis/custom_textformfield.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  Future<void> turnOnGPS() async {
    Location location = new Location();
    bool ison = await location.serviceEnabled();
    if (!ison) {
      //if defvice is off
      bool isturnedon = await location.requestService();
      if (isturnedon) {
        print("GPS device is turned ON");
      } else {
        print("GPS Device is still OFF");
      }
    }
  }

  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isChecked = false;

  void _loadUserEmailPassword() async {
    // print("Load Email");
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var userName = prefs.getString("userName") ?? "";
      var password = prefs.getString("password") ?? "";
      var remeberMe = prefs.getBool("remember_me") ?? false;

      print(remeberMe);
      print(userName);
      print(password);
      if (remeberMe) {
        setState(() {
          isChecked = true;
        });
        userNameController.text = userName ?? "";
        passwordController.text = password ?? "";
      }
    } catch (e) {
      print(e);
    }
  }

  void _handleRemeberme(dynamic value) {
    print("Handle Rember Me");
    isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('userName', userNameController.text);
        prefs.setString('password', passwordController.text);
      },
    );
    setState(() {
      isChecked = value;
    });
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  HttpServices service = HttpServices();
  LogInController logInController = Get.put(LogInController());
  bool isLoading = false;
  bool _isHidden = true;
  bool _passwordVisible = false;

  @override
  void dispose() {
    userNameController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadUserEmailPassword();
    // _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            padding: const EdgeInsets.all(0),
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Main New BG.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  CustomBoldText(
                    text: "Welcome",
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.1,
                  ),
                  CustomTextFormField(
                    isObsecure: false,
                    labelText: "Username",
                    fieldIcon: Icons.person,
                    val: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter valid Username';
                      }
                      return null;
                    },
                    fieldController: userNameController,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.05,
                  ),
                  CustomTextFormFieldPassword(
                    isObsecure: _isHidden,
                    labelText: "Password",
                    fieldIcon: Icons.lock,
                    visibility: IconButton(
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(
                          () {
                            _passwordVisible = !_passwordVisible;
                            _isHidden = !_isHidden;
                          },
                        );
                      },
                    ),
                    //visibility: Icons.visibility,
                    val: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    fieldController: passwordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          activeColor: Color(0xff00C8E8),
                          value: isChecked,
                          onChanged: _handleRemeberme),
                      const Text(
                        "Save my credentials",
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      turnOnGPS();
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      if (_formKey.currentState!.validate()) {
                        setState(() {
                          logInController.getUserData(
                              userNameController.text, passwordController.text);

                          Get.put(HomeScreenController());
                          isLoading = false;
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff01b0b5),
                    ),
                    child: (isLoading)
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 3.5,
                            ))
                        : const Text(
                            "LOGIN",
                            style: TextStyle(
                              fontSize: 21,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
