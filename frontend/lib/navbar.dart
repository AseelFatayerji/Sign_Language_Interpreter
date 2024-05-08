import 'package:flutter/material.dart';

import 'home.dart';
import 'login.dart';
import 'translate.dart';
import 'language.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() =>
      _NavbarState();
}

class _NavbarState
    extends State<Navbar> {
  
  @override
  Widget build(BuildContext context) {
    
    int myIndex = 1;
    List<Widget> pages = const [
      LanguagePage(),
      HomePage(),
      TranslationPage(),
    ];
    return Scaffold(
        body: IndexedStack(
          index: myIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 37, 37, 37),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(255, 146, 146, 146),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.translate),
              label: "Set Language",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Translate"),
          ],
          onTap: (int index) {
            setState(() {
              myIndex = index;
            });
          },          
          currentIndex: myIndex,
        ),
      );
  }
}