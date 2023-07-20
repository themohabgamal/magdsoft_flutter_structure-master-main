// ignore_for_file: public_member_api_docs, sort_constructors_first, must_be_immutable
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';

class VerifyScreen extends StatefulWidget {
  String? code;
  VerifyScreen({
    Key? key,
    required this.code,
  }) : super(key: key);
  @override
  _VerifyScreenState createState() => _VerifyScreenState();
}

class _VerifyScreenState extends State<VerifyScreen> {
  String otpString = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            child: Image.asset(
              "assets/images/overlay.png",
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              const SizedBox(
                height: 170,
              ),
              const Text(
                "Verify phone",
                style: TextStyle(fontSize: 30.0, color: Colors.white),
              ),
              const SizedBox(
                height: 15,
              ),
              OTPTextField(
                length: 4,
                width: MediaQuery.of(context).size.width,
                fieldWidth: 80,
                style: const TextStyle(fontSize: 17),
                textFieldAlignment: MainAxisAlignment.spaceAround,
                fieldStyle: FieldStyle.box,
                onCompleted: (pin) {
                  otpString = pin;
                },
              ),
              TextButton(
                  onPressed: () {
                    Fluttertoast.showToast(msg: "Otp has been resend again");
                  },
                  child: const Text(
                    "Resend code",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
                  )),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (widget.code == otpString) {
                    Fluttertoast.showToast(
                        msg: "Verification completed successfully");
                    Navigator.of(context).pushNamed('/home');
                  }
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                  child: Text(
                    'Verify',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400),
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
        ],
      ),
    );
  }
}
