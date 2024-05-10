import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Align(
          alignment: Alignment.center,
          child: Column(
            children: [
              Container(
                height: 300,
                width: 300,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                child: const Image(
                  alignment: Alignment.center,
                  image: AssetImage("assets/logo-transparent.png"),
                ),
              ),
              const Text(
                'Silent Learning',
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 20.0,
                ),
              )
            ],
          )),
    );
  }
}
