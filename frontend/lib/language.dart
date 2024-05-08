import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage ({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 37, 35, 38),
      ),
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 113, 212, 204),
            border: Border.all(color: Colors.transparent),
          ),
          child: const Text(
            'Test',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
            ),
          ),

        )
      ),
    );
  }
}