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
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Text(
                    "From",
                    style: TextStyle(fontSize: 28),
                  ),
                ),
                Container(
                  color: Colors.white,
                  margin: const EdgeInsets.symmetric(horizontal: 10),
                  child: const Text(
                    "To",
                    style: TextStyle(fontSize: 28),
                  ),
                )
              ],
            ),
          )),
    );
  }
}
