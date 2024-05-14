import 'package:flutter/material.dart';
import 'home.dart';
import 'language.dart';
import 'translate.dart';
import 'teaching.dart';
import 'profile.dart';

class TeachNav extends StatefulWidget {
  @override
  _TeachNavState createState() => _TeachNavState();
}

class _TeachNavState extends State<TeachNav> {
  int _selectedIndex = 2;
  final List<Widget> _screens = <Widget>[
    const LanguagePage(),
    const HomePage(),
    TranslationPage(),
    ModelUpdate(),
    ProfileScreen()
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
      drawer: Drawer(
        child: SafeArea(child:Column(
          children: [],
        ))
      ),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}
