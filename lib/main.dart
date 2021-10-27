import 'package:flutter/material.dart';
import 'package:hairdresser/presentation/screens/login/home_screen.dart';
import 'package:hairdresser/presentation/screens/login/launch_screen.dart';
import 'package:hairdresser/presentation/screens/login/login_screen.dart';
import 'package:hairdresser/presentation/screens/home/Home.dart';
void main() {
  runApp(MaterialApp(
    initialRoute: "/home",
    debugShowCheckedModeBanner: false,
    routes: {
      //"/": (context) => const LaunchScreen(),
      "/home": (context) => const HomePage(),
      "/login": (context) => const LoginPage(),
      "/homepage": (context) => const MyHomePage()
    },
  ));
}