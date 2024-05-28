import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:otp_verify/Screens/MainScreen.dart';
import 'package:otp_verify/Services/auth_functions.dart';
import 'package:otp_verify/model/user_model.dart';

import '../utils/buttons.dart';

class EnterUserDetails extends StatefulWidget {
  String phoneNumber, uid;

  EnterUserDetails({required this.phoneNumber, required this.uid});

  @override
  State<EnterUserDetails> createState() => _EnterUserDetailsState();
}

class _EnterUserDetailsState extends State<EnterUserDetails> {
  storeDetails({required}) {}
  TextEditingController nameController = TextEditingController();
  TextEditingController streetController = TextEditingController();
  TextEditingController villageController = TextEditingController();
  TextEditingController talukaController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController zipController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'name'.tr,
                    controller: nameController,
                    icon: const Icon(Icons.person)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'street'.tr,
                    controller: streetController,
                    icon: const Icon(Icons.roundabout_left_rounded)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'village'.tr,
                    controller: villageController,
                    icon: const Icon(Icons.location_history)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'taluka'.tr,
                    controller: talukaController,
                    icon: const Icon(Icons.location_history)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'district'.tr,
                    controller: districtController,
                    icon: const Icon(Icons.location_history)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    keyboardType: TextInputType.number,
                    labelText: 'zip'.tr,
                    controller: zipController,
                    icon: const Icon(Icons.numbers_rounded)),
                SizedBox(height: 10),
                Buttons.CustomTextField(
                    labelText: 'state'.tr,
                    controller: stateController,
                    icon: const Icon(Icons.map)),
                SizedBox(height: 20),
                ElevatedButton(
                    style: Buttons.ElevatedButtonStyle(),
                    onPressed: () async {
                      UserModel user = UserModel(
                        name: nameController.text.trim(),
                        district: districtController.text.trim(),
                        phone: widget.phoneNumber,
                        state: stateController.text.trim(),
                        street: streetController.text.trim(),
                        taluka: talukaController.text.trim(),
                        uid: widget.uid,
                        village: villageController.text.trim(),
                        zip: int.parse(zipController.text.trim()),
                      );
                      await AuthFunctions().createUser(user);
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MainScreen()));
                    },
                    child: (isLoading)
                        ? const Center(child: CircularProgressIndicator())
                        : Center(
                            child: Text(
                              "continue".tr,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
