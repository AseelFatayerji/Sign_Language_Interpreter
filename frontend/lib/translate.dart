import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:translator/translator.dart';

import 'package:http/http.dart' as http;
import 'global.dart' as global;

class TranslationPage extends StatefulWidget {
  const TranslationPage({super.key});

  @override
  TranslationPageState createState() => TranslationPageState();
}

class TranslationPageState extends State<TranslationPage> {
  final translator = GoogleTranslator();
  late Timer timer;
  bool isCapturing = false;
  var btn = "Start";

  CameraImage? cameraImage;
  CameraController? controller;
  String output = "Translation";

  @override
  void initState() {
    super.initState();
    translator.translate(output, to: global.language).then((result) {
      setState(() {
        output = result.text;
      });
    });

    loadCamera();
  }

  void dispose() {
    controller!.dispose();
    timer.cancel();
    super.dispose();
  }

  loadCamera() {
    controller = CameraController(camera!.first, ResolutionPreset.veryHigh);
    controller!.initialize();
  }

  startTimer() {
    if (btn == "Start") {
      setState(() {
        btn = "Stop";
        return;
      });
      timer = Timer.periodic(const Duration(seconds: 3), (timer) async {
        if (!isCapturing) {
          try {
            XFile? imageFile = await controller!.takePicture();
            await getPredictions(File(imageFile.path));
          } catch (err) {
            debugPrint("Error capturing/sending image: $err");
          }
        }
      });
    } else {
      setState(() {
        btn = "Start";
        return;
      });
      timer.cancel();
    }
  }

  getPredictions(File imageFile) async {
    var apiUrl = Uri.parse('http://${global.ipv4}:8000/translate');
    try {
      var request = http.MultipartRequest('POST', apiUrl);
      request.files
          .add(await http.MultipartFile.fromPath('image', imageFile.path));
      var response = await request.send();

      if (response.statusCode == 200) {
        debugPrint("Image uploaded successfully!");
      } else {
        debugPrint("Failed to upload image. Error: ${response.reasonPhrase}");
      }
    } catch (err) {
      debugPrint("Error sending image: $err");
    }
  }

  Widget build(BuildContext context) {
    if (controller == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: !controller!.value.isInitialized
              ? Container()
              : AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.white60,
                  borderRadius: BorderRadius.circular(5)),
              child: Text(
                output,
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                startTimer();
              },
              style: TextButton.styleFrom(
                backgroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                btn,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16.0,
                ),
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
