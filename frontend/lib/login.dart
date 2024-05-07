import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key,}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
         backgroundColor: Color.fromARGB(255, 37, 35, 38),
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