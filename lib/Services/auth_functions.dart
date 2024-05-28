import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Screens/enter_otp.dart';
import '../model/user_model.dart';

class AuthFunctions {
  static FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  static Future verifyPhoneNumber(
      {required String phoneNumber,
      required bool isSignUp,
      required String type,
      List<String>? userdata,
      required BuildContext context}) async {
    try {
      await FirebaseAuth.instance.verifyPhoneNumber(
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) async {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                backgroundColor: Colors.white,
                behavior: SnackBarBehavior.floating,
                content: ListTile(
                  leading: Icon(Icons.error, color: Colors.red),
                  title: Text(
                      // 'Please enter valid phone number',
                      "Enter valid phone number" + e.toString()),
                ),
              ),
            );
          },
          codeSent: (String verificationID, int? resendToken) {
            print("Code sent");
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: ((context) => EnterOTP(
                          verificationID: verificationID,
                          PhoneNumber: phoneNumber,
                          isSignUp: isSignUp,
                          type: type,
                          userdata: userdata,
                        ))));
          },
          codeAutoRetrievalTimeout: (String verification) {},
          phoneNumber: phoneNumber);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Backend Exception' + e.toString())));
    }
  }

  Future<void> createUser(UserModel user) async {
    try {
      Map<String, dynamic> data = {
        "name": user.name,
        "phone": user.phone,
        "uuid": user.uid,
        "street": user.street,
        "village_city": user.village,
        "taluka": user.taluka,
        "district": user.district,
        "zip": user.zip,
        "state": user.state
      };
      await firestore.collection('Users').add(data);

      print('Data added successfully.');
    } catch (e) {
      print("Error ouccured while creating the user: ${e.toString()}");
      throw Exception(e.toString());
    }
  }

  Future<bool> checkUserExistence(String phoneNumber) async {
    try {
      QuerySnapshot querySnapshot = await firestore
          .collection('Users')
          .where('phone', isEqualTo: phoneNumber)
          .get();
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      print("Error checking user existence :");
      throw Exception(e.toString());
    }
  }
}
