import 'dart:async';

import 'package:chat_app_admin/screens/home_page.dart';
import 'package:chat_app_admin/screens/auth/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(context) {
    //
    //
    final auth = FirebaseAuth.instance;
    //
    final user = auth.currentUser;
    //
    if (user != null) {
      //
      // Timer(
      //   Duration(seconds: 3),
      //   () => Navigator.pushReplacement(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => HomePage(
      //         title: "Home",
      //       ),
      //     ),
      //   ),
      // );

      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(
              title: 'Home',
            ),
          ),
        ),
      );
    } else {
      Timer(
        Duration(seconds: 3),
        () => Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LogINPage(),
          ),
        ),
      );
    }
  }
}
