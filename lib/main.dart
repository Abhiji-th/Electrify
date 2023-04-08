import 'package:electrifyy/MainPage.dart';
import 'package:electrifyy/devices.dart';
import 'package:electrifyy/live.dart';
import 'package:electrifyy/login.dart';
import 'package:electrifyy/nav.dart';
import 'package:electrifyy/password.dart';
import 'package:electrifyy/prediction.dart';
import 'package:electrifyy/bill.dart';
import 'package:electrifyy/signup.dart';
import 'package:electrifyy/splash_screen.dart';
import 'forgot.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'home.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

final navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'My App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      routes: {
        '/signup': (context) => signup(),
        '/splash': (context) => SplashScreen(),
        '/login': (context) => login(),
        '/home': (context) => HomePage(),
        '/devices': (context) => device(),
        //'/page2': (context) => live(),
        '/prediction': (context) => prediction(),
        '/bill': (context) => bill(),
        '/forgotpassword':(context) =>forgotpassword(),
        '/password':(context) =>password(),
        '/nav':(context) =>nav(),
      },
    );
  }
}