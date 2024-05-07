import 'package:flutter/material.dart';
import 'home.dart';
import 'login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Learning',
      home: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color.fromARGB(255, 37, 35, 38),
          selectedItemColor: Colors.white,
          unselectedItemColor: const Color.fromARGB(100, 146, 146, 146),
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.translate), label: "Set Language", ),
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.video_call), label: "Translate"),
          ],
        ),
      ),
    );
  }
}
