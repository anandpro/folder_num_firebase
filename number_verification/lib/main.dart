import 'package:chat_app_admin/screens/home_page.dart';
import 'package:chat_app_admin/screens/auth/login.dart';
import 'package:chat_app_admin/screens/splash.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

///   flutter build apk --release
///  flutter build appbundle --target-platform android-arm,android-arm64,android-x64
///  flutter build appbundle --target-platform android-arm
/// flutter build apk --analyze-size --target-platform android-arm
/// flutter run -d chrome --web-browser-flag "--disable-web-security"
///   F:\@ Program_Files\flutter\bin\cache\dart-sdk
///

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Project',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: SplashScreen());
  }
}


// home:StreamBuilder<User?>(
//         stream: FirebaseAuth.instance.authStateChanges(),
//         builder: (context, snapshot) {
//           if (snapshot.hasError) {
//             return Text(snapshot.error.toString());
//           }
//           if (snapshot.connectionState == ConnectionState.active) {
//             if (snapshot.data == null) {
//               return LogINPage();
//             } else {
//               return HomePage(
//                 title: FirebaseAuth.instance.currentUser!.displayName!,
//               );
//             }
//           }
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),