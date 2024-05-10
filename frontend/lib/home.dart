import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({
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
          child: Stack(children: [
            Container(
              decoration: const ShapeDecoration(
                  color: Color.fromARGB(255, 0, 0, 0), shape: CircleBorder()),
              height: 150,
              width: 150,
              // child: Image(image: AssetImage()),
            ),
            Container(
              height: 500,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 238, 238, 238),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
                border: Border.all(color: Colors.transparent),
              ),
              child: const Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'How to use',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '1.Allow camera use.\n2.Stand in front of the camera with both hands visible.\n3.Click on the camera icon.\n4.Happy signing :).\n5.Change the selected language in the language section (Optional).',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
            )
          ])),
    );
  }
}
