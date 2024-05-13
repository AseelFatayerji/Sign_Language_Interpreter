import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:camera/camera.dart';

import 'navbar.dart';
import 'splash.dart';

List<CameraDescription>? cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Silent Learning',
      home: AnimatedSplashScreen(
          duration: 3000,
          splash: const SplashScreen(),
          splashIconSize: 300,
          centered: true,
          nextScreen: Navbar(),
          splashTransition: SplashTransition.fadeTransition),
    );
  }
}
