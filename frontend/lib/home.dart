import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Align(
          alignment: Alignment.bottomCenter,
          child: Stack(
              alignment: Alignment.topCenter,
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 500,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 238, 238, 238),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0),
                    ),
                    border: Border.all(color: Colors.transparent),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      const Text(
                        'How to use',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      CarouselSlider(
                          items: [
                            'Allow camera use',
                            'Stand in front of the camera with both hands visible',
                            'Change the selected language in the language section (Optional)',
                            'Click on the camera icon',
                            'Happy signing :)'
                          ].map((e) {
                            return Column(
                              children: [
                                Container(
                                    width: MediaQuery.of(context).size.width,
                                    child: const Image(
                                      alignment: Alignment.center,
                                      height: 150,
                                      width: 150,
                                      image: AssetImage(
                                          "assets/logo-transparent.png"),
                                    )),
                                Text("$e")
                              ],
                            );
                          }).toList(),
                          options: CarouselOptions(height: 200)),
                      const SizedBox(
                        height: 100,
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: -80,
                  child: Container(
                    decoration: const ShapeDecoration(
                        color: Color.fromARGB(255, 238, 238, 238),
                        shape: CircleBorder()),
                    height: 160,
                    width: 160,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: const Image(
                      alignment: Alignment.center,
                      image: AssetImage("assets/logo-transparent.png"),
                    ),
                  ),
                )
              ])),
    );
  }
}
