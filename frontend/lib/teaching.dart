import 'package:flutter/material.dart';

class ModelUpdate extends StatelessWidget {
  const ModelUpdate({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black38,
      body: Align(
        alignment: Alignment.topCenter,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white54,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.transparent),
          ),
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          child: const Text(
            'Translation',
            style: TextStyle(
              color: Colors.white70,
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }
}
