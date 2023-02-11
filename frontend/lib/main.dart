// ignore_for_file: prefer_const_constructors, unused_import

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:unscript_app/app/app.dart';
import 'package:unscript_app/login/layout/set_pass_screen.dart';
import 'package:unscript_app/login/layout/succes_pass_screen.dart';
import 'package:unscript_app/login/login.dart';
import 'package:unscript_app/register/layout/verify_otp_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  const orientations = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ];
  SystemChrome.setPreferredOrientations(orientations);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget home = const Scaffold();

  @override
  void initState() {
    switchHome();
    super.initState();
  }

  void switchHome() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? session = sharedPreferences.getString("session");
    if (session == null) {
      setState(() {
        home = const Login();
      });
    } else {
      setState(() {
        home = App();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "UnScript Hackathon",
      debugShowCheckedModeBanner: false,
      home: home,
    );
  }
}
