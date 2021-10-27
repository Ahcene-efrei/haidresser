import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hairdresser/presentation/screens/home/catalog_page.dart';
import 'package:hairdresser/presentation/screens/home/calendar_page.dart';
import 'package:hairdresser/presentation/screens/home/home_page.dart';
import 'package:hairdresser/presentation/screens/profil/profil_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int currentIndex = 0;
  final screens = [
    HomePage(),
    CatalogPage(),
    CalendarPage(),
    ProfilScreen(),
  ];

  @override
  Widget build(BuildContext context) =>
      Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          type : BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          unselectedItemColor: Colors.black38,
          currentIndex: currentIndex,
          selectedItemColor: Colors.black,
          onTap: (index) => setState(() => currentIndex = index),
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.list),
              label: 'Catalog',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.calendar_today_sharp),
              label: 'calendar',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_box),
              label: 'Account',
            )
          ],

        ),
      );
}