import 'package:flutter/material.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({
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
          alignment: Alignment.bottomCenter,
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 113, 212, 204),
              border: Border.all(color: Colors.transparent),
            ),
            child: Row(
              children: [
                Container(
                  color: Colors.red,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Text nest1",
                    style: TextStyle(fontSize: 32),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "Text nest2",
                    style: TextStyle(fontSize: 32),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
