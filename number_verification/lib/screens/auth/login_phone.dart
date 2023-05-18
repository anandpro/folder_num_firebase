import 'package:chat_app_admin/screens/auth/check_otp.dart';
import 'package:chat_app_admin/utils/snack_bar.dart';
import 'package:chat_app_admin/widget/round_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LogPhone extends StatefulWidget {
  LogPhone({Key? key}) : super(key: key);

  @override
  _LogPhoneState createState() => _LogPhoneState();
}

class _LogPhoneState extends State<LogPhone> {
  //
  bool loading = false;
  final auth = FirebaseAuth.instance;
  final _phone = TextEditingController();
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone"),
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
              decoration: InputDecoration(hintText: "+ 91 "),
            ),
          ),
          RoundedButton(
              loading: loading,
              title: "Enter",
              onTap: () {
                setState(() {
                  loading = true;
                });
                auth.verifyPhoneNumber(
                    phoneNumber: "+91" + _phone.text,
                    verificationCompleted: (_) {
                      setState(() {
                        loading = false;
                      });
                    },
                    verificationFailed: (e) {
                      setState(() {
                        loading = false;
                      });
                      Utils().snackBar("Faild", context);
                    },
                    codeSent: (String verificationId, int? toeken) {
                      setState(() {
                        loading = false;
                      });
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => VerifyOtp(
                                    verificationId: verificationId,
                                  )));
                    },
                    codeAutoRetrievalTimeout: (e) {
                      Utils().snackBar("Time Out", context);
                    });
              })
        ],
      ),
    );
  }
}
