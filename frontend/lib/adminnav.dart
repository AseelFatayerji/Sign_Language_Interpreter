import 'package:flutter/material.dart';
import 'home.dart';
import 'language.dart';
import 'translate.dart';
import 'teaching.dart';
import 'profile.dart';
import 'userList.dart';
import 'admin.dart';

class AdminNav extends StatefulWidget {
  const AdminNav({super.key});

  @override
  AdminNavState createState() => AdminNavState();
}

class AdminNavState extends State<AdminNav> {
  int _selectedIndex = 1;
  final List<Widget> _screens = <Widget>[
    const HomePage(),
    AdminPanel(),
    const ProfileScreen(),
    const UserList(),
    const ModelUpdate(),
    const LanguagePage(),
    const TranslationPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Color.fromARGB(255, 113, 212, 204),),
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
                  Icons.admin_panel_settings,
                ),
                title: const Text('Admin Panel'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 1;
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
                    _selectedIndex = 2;
                  });
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.people,
                ),
                title: const Text('User List'),
                onTap: () {
                  setState(() {
                    _selectedIndex = 3;
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
                    _selectedIndex = 4;
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
                    _selectedIndex = 5;
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
                    _selectedIndex = 6;
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
