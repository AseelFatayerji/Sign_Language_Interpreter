import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: const Color.fromARGB(255, 37, 35, 38),
      ),
      body: Center(
        child: TextButton(
          onPressed: () {},
          child: const Text('Start'),
          
        ),
      ),
    );
  }
}