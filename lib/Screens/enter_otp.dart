import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_verify/Screens/MainScreen.dart';
import 'package:pinput/pinput.dart';

import 'Enter_user_details_screen.dart';
import '../Services/auth_functions.dart';
import '../utils/colors.dart';

class EnterOTP extends StatefulWidget {
  final String verificationID;
  final List<String>? userdata;
  final String PhoneNumber;
  final bool isSignUp;
  final String type;
  const EnterOTP(
      {super.key,
      this.userdata,
      required this.verificationID,
      required this.PhoneNumber,
      required this.isSignUp,
      required this.type});

  @override
  State<EnterOTP> createState() => _EnterOTPState();
}

class _EnterOTPState extends State<EnterOTP> {
  bool isLoading = false;
  String myOTP = "";

  final defaultPinTheme = PinTheme(
    width: 40,
    height: 60,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black)),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 40),
                Text(
                  "otp_verification".tr,
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "otp_msg".tr + " ${widget.PhoneNumber}",
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(color: Colors.grey),
                ),
                SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Pinput(
                      length: 6,
                      defaultPinTheme: defaultPinTheme,
                      focusedPinTheme: defaultPinTheme.copyWith(
                        decoration: defaultPinTheme.decoration!.copyWith(
                          border: Border.all(color: primaryColor),
                        ),
                      ),
                      onCompleted: (pin) => myOTP = pin,
                    ),
                  ],
                ),
                SizedBox(height: 20),
                ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        PhoneAuthCredential credential =
                            PhoneAuthProvider.credential(
                                verificationId: widget.verificationID,
                                smsCode: myOTP);
                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) async {
                          String uid = FirebaseAuth.instance.currentUser!.uid;
                          String phone =
                              FirebaseAuth.instance.currentUser!.phoneNumber!;

                          bool isPresent =
                              await AuthFunctions().checkUserExistence(phone);
                          if (isPresent) {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MainScreen()));
                          } else {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EnterUserDetails(
                                        phoneNumber: phone, uid: uid)));
                          }
                        });
                      } catch (e) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text("Error : ")));
                      }
                      setState(() => isLoading = false);
                    },
                    child: (isLoading)
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : Center(
                            child: Text(
                              "continue".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
