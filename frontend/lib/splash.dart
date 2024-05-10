import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo-transparent.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: const Text(
          'Silent Learning',
          style: TextStyle(
            color: Color.fromARGB(255, 113, 212, 204),
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ));
  }
}
