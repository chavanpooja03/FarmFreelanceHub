import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:otp_verify/Screens/Enter_user_details_screen.dart';

import 'Screens/Enter_phone.dart';
import 'firebase_options.dart';

Future<void> main() async {
// ...

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(otpVerify());
}

class otpVerify extends StatefulWidget {
  const otpVerify({super.key});

  @override
  State<otpVerify> createState() => _otpVerifyState();
}

class _otpVerifyState extends State<otpVerify> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(builder: (context, child) {
      return GetMaterialApp(
          themeMode: ThemeMode.system, home: EnterPhonePage());
    });
  }
}
