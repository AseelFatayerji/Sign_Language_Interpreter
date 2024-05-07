import 'package:flutter/material.dart';

class TranslationPage extends StatelessWidget {
  const TranslationPage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 37, 35, 38),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Select Language'),
          
        ),
      ),
    );
  }
}