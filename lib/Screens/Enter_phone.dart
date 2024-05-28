import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:otp_verify/Services/auth_functions.dart';

class EnterPhonePage extends StatefulWidget {
  const EnterPhonePage({super.key});

  @override
  State<EnterPhonePage> createState() => _EnterPhonePageState();
}

class _EnterPhonePageState extends State<EnterPhonePage> {
  @override
  bool isLoading = false;
  PhoneNumber number = PhoneNumber(dialCode: '+91');

  void toggleLoading() {
    setState(() => isLoading = !isLoading);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
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
                "otp_instruction".tr,
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: Colors.grey),
              ),
              SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [BoxShadow(color: Colors.grey.shade200)],
                ),
                child: InternationalPhoneNumberInput(
                    initialValue: PhoneNumber(isoCode: "IN"),
                    inputDecoration: InputDecoration(
                        hintText: 'phone_number'.tr,
                        labelStyle: TextStyle(color: Colors.black),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 20)),
                    onInputChanged: (PhoneNumber phoneNumber) {
                      number = phoneNumber;
                      print(phoneNumber);
                    }),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12))),
                  onPressed: () async {
                    toggleLoading();
                    try {
                      await AuthFunctions.verifyPhoneNumber(
                          phoneNumber: number.phoneNumber.toString(),
                          isSignUp: false,
                          type: "login",
                          context: context);
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text("Enter Phone Number :" + e.toString())));
                    }
                    toggleLoading();
                  },
                  child: Center(
                      child: (isLoading)
                          ? const CircularProgressIndicator()
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Text(
                                "continue".tr,
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                            )))
            ],
          ),
        ),
      ),
    );
  }
}
