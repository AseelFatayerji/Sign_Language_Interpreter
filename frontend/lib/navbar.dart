import 'package:flutter/material.dart';
import 'home.dart';
import 'language.dart';
import 'translate.dart';
import 'login.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int _selectedIndex = 1;
  final List<Widget> _screens = <Widget>[
    const LanguagePage(),
    const HomePage(),
    TranslationPage(),
    LoginPage(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 35, 38),
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color.fromARGB(255, 37, 35, 38),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.fixed,
        iconSize: 35,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.translate,
            ),
            label: 'Language',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.video_call,
            ),
            label: 'Transalte',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.login_sharp,
            ),
            label: 'Login',
          ),
        ],
        onTap: _onItemTap,
        selectedItemColor: Colors.white,
        unselectedFontSize: 13.0,
        unselectedItemColor: const Color.fromARGB(255, 144, 144, 114),
      ),
    );
  }
}
