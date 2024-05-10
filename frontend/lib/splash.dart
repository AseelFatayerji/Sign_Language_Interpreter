import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.bottomCenter,
        height: 200,
        width: 200,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/logo-transparent.png"),
            fit: BoxFit.contain,
          ),
        ),
        child: const Text(
          '\n\nSilent Learning',
          style: TextStyle(
            color: Color.fromARGB(255, 113, 212, 204),
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        ));
  }
}
