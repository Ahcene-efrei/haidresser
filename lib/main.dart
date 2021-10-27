import 'package:flutter/material.dart';
import 'package:labonnecoupe/presentation/screens/login/home_screen.dart';
import 'package:labonnecoupe/presentation/screens/login/launch_screen.dart';
import 'package:labonnecoupe/presentation/screens/login/login_screen.dart';
import 'package:labonnecoupe/presentation/screens/home/Home.dart';
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