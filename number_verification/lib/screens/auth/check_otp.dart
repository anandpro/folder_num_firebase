import 'package:chat_app_admin/screens/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/snack_bar.dart';
import '../../widget/round_button.dart';

class VerifyOtp extends StatefulWidget {
  final String verificationId;
  VerifyOtp({Key? key, required this.verificationId}) : super(key: key);

  @override
  _VerifyOtpState createState() => _VerifyOtpState();
}

class _VerifyOtpState extends State<VerifyOtp> {
  //
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _phone = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check OTP"),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text("Login with Phone"),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextFormField(
              keyboardType: TextInputType.number,
              controller: _phone,
              decoration: InputDecoration(hintText: " 6 Digit Otp"),
            ),
          ),
          RoundedButton(
              loading: loading,
              title: "Enter OTP",
              onTap: () async {
                setState(() {
                  loading = true;
                });
                final crendential = PhoneAuthProvider.credential(
                    verificationId: widget.verificationId,
                    smsCode: _phone.text.toString());

                try {
                  await auth.signInWithCredential(crendential);
                  setState(() {
                    loading = false;
                  });
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => HomePage(
                                title: 'Home',
                              )));
                } catch (e) {
                  Utils().snackBar(e.toString(), context);
                  setState(() {
                    loading = false;
                  });
                }
              }),
        ],
      ),
    );
  }
}
