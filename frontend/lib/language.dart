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
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
              border: Border.all(color: Colors.transparent),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: (MainAxisSize.min),
              children: [
                const Text(
                  'Select Language',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28.0,
                  ),
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'From',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        child: TextButton(
                          onPressed: () {},
                          style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 25.0, vertical: 10.0),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text(
                            'To',
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 20.0,
                            ),
                          ),
                        ),
                      )
                    ])
              ],
            ),
          )),
    );
  }
}
