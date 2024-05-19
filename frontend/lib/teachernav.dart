import 'package:flutter/material.dart';
import 'home.dart';
import 'language.dart';
import 'translate.dart';
import 'teaching.dart';
import 'profile.dart';

class TeachNav extends StatefulWidget {
  const TeachNav({super.key});

  @override
  TeachNavState createState() => TeachNavState();
}

class TeachNavState extends State<TeachNav> {
  int _selectedIndex = 1;
  final List<Widget> _screens = <Widget>[
    const HomePage(),
    ProfileScreen(),
    const ModelUpdate(),
    const LanguagePage(),
    const TranslationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 113, 212, 204),
        ),
      ),
      drawer: Drawer(
          backgroundColor: Colors.white,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              ListTile(
                leading: const Icon(
                  Icons.home,
                ),
                title: const Text('Home'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 0;
                  });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.person,
                ),
                title: const Text('Profile'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
                  });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.add_box_rounded,
                ),
                title: const Text('Add words'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 2;
                  });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.translate,
                ),
                title: const Text('Language Select'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
                  });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.video_call,
                ),
                title: const Text('Translate'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 4;
                  });
                },
              )
            ],
          )),
      body: Center(
        child: _screens.elementAt(_selectedIndex),
      ),
    );
  }
}
