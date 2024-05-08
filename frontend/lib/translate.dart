import 'package:flutter/material.dart';

class TranslationPage extends StatelessWidget {
  const TranslationPage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 37, 35, 38),
      ),
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.topCenter,
        child: TextButton(
          onPressed: () {},
          style: TextButton.styleFrom(
            backgroundColor: const Color.fromARGB(122, 255, 255, 255),
          ),
          child: const Text('Translation',style: TextStyle(
              color: Colors.white54,
              fontSize: 18.0,
            ),),
        ),
      ),
    );
  }
}
