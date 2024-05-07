import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';
import 'translate.dart';
import 'language.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    int myIndex = 1;
    List<Widget> pages = const [LanguagePage(),HomePage(),TranslationPage() , ];
    return MaterialApp(
      title: 'Silent Learning',
      home: Scaffold(
        body: IndexedStack(
          index: myIndex,
          children: pages,
        ),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 37, 37, 37),
          currentIndex: myIndex,
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(100, 146, 146, 146),
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.translate),
              label: "Set Language",
            ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Translate"),
          ],
          type: BottomNavigationBarType.shifting,
          onTap: (int index) {
            myIndex = index;
          },
        ),
      ),
    );
  }
}
