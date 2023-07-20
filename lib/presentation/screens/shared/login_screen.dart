import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:magdsoft_flutter_structure/data/data_providers/remote/http_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  final formkey = GlobalKey<FormState>();
  late SharedPreferences loginData;
  late bool newUser;
  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Stack(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Stack(
                        children: [
                          Image.asset(
                            "assets/images/login.png",
                            fit: BoxFit.cover,
                          ),
                          Opacity(
                            opacity: 0.4,
                            child: Container(
                              color: Colors.blue,
                              width: double.infinity,
                              height: 350,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              Positioned(
                  top: 280,
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 200,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40))),
                  ))
            ],
          ),
          Positioned(
            top: 200,
            right: 10,
            child: Container(
              padding: const EdgeInsets.all(20),
              width: 372,
              height: 345,
              decoration: const BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 20.0,
                      offset: Offset(
                        0,
                        1,
                      ),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40))),
              child: Column(
                children: [
                  Text(
                    "Welcome",
                    style: Theme.of(context).textTheme.headline4?.copyWith(
                        color: const Color.fromARGB(255, 62, 62, 62)),
                  ),
                  const Divider(
                    color: Colors.blue,
                    thickness: 3,
                    indent: 120,
                    endIndent: 120,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Form(
                    key: formkey,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: nameController,
                              validator: (value) {
                                if (value == null) {
                                  return "name can't be empty";
                                } else {
                                  return null;
                                }
                              },
                              textAlign: TextAlign.left,
                              decoration: InputDecoration(
                                hintText: 'Enter your full name',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(5),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.8),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: TextFormField(
                              controller: phoneController,
                              textAlign: TextAlign.left,
                              validator: (value) {
                                if (value!.length < 10 && value.length > 15) {
                                  return "please enter a valid phone";
                                } else {
                                  return null;
                                }
                              },
                              decoration: InputDecoration(
                                hintText: 'Enter your phone number',
                                hintStyle: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 16,
                                ),
                                contentPadding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          ElevatedButton(
                            onPressed: () async {
                              //http verify post request
                              if (formkey.currentState!.validate()) {
                                // Perform login action here
                                var response = await HttpHelper.verifyPhone(
                                    nameController.text, phoneController.text);
                                Fluttertoast.showToast(msg: response.message!);
                                loginData.setBool('login', false);
                                loginData.setString(
                                    'phone', phoneController.text);
                                // send otp code to next screen
                                Navigator.of(context).pushNamed('/verify',
                                    arguments: response.code);
                              }
                            },
                            child: const Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 80, vertical: 15),
                              child: Text(
                                'Login',
                                style: TextStyle(fontSize: 22),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              top: 600,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: const <Widget>[
                        Expanded(
                          child: Divider(
                            color: Colors.blue,
                            thickness: 1,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            "OR",
                            style: TextStyle(fontSize: 18, color: Colors.blue),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            color: Colors.blue,
                            thickness: 1,
                          ),
                        ),
                      ],
                    ),
                  ))),
          Positioned(
            top: 650,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset("assets/images/google.png"),
                  Image.asset("assets/images/apple.png"),
                  Image.asset("assets/images/facebook.png"),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void isUserLoggedIn() async {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool('login') ?? true);
    if (newUser == false) {
      Navigator.pushReplacementNamed(context, '/navigator',
          arguments: loginData);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }
}
