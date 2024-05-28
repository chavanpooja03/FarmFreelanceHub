import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OTPScreen extends StatelessWidget {
  const OTPScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP Verification',
              style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.bold, fontSize: 80.0),
            ),
            Text('Enter OTP here',
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 40.0),
            OtpTextField(
              mainAxisAlignment: MainAxisAlignment.center,
              numberOfFields: 6,
              fillColor: Colors.black.withOpacity(0.1),
              filled: true,
              onSubmit: (code) => print("OTP is => $code"),
              borderColor: Color(0xFF512DA8),
              fieldWidth: 40.0,
              textStyle: TextStyle(fontSize: 20.0),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20.0),
            SizedBox(
              width: double.infinity,
              child:
                  ElevatedButton(onPressed: () {}, child: const Text('Next')),
            ),
          ],
        ),
      ),
    );
  }
}
