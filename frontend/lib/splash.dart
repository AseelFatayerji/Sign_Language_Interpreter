import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Container(
          height: 200,
          width: 200,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: const Image(
            alignment: Alignment.center,
            image: AssetImage("assets/logo-transparent.png"),
          ),
        ),
        const Text(
          'Silent Learning',
          style: TextStyle(
            color: Color.fromARGB(255, 113, 212, 204),
            fontWeight: FontWeight.bold,
            fontSize: 22.0,
          ),
        )
      ],
    );
  }
}
