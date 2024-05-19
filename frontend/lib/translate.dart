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

  @override
  void dispose() {
    controller!.dispose();
    timer.cancel();
    super.dispose();
  }

  loadCamera() {
    controller = CameraController(camera!.last, ResolutionPreset.veryHigh);
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
            getPredictions(File(imageFile.path));
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
    var response = await http.post(
      apiUrl,
      body: {'image': imageFile.path}, // Use 'image' as the field name
      headers: {
        'Content-Type':
            'application/octet-stream', // Set the content type as binary data
      },
    );
    if (response.statusCode == 200) {
      debugPrint("Image uploaded successfully!");
    } else {
      debugPrint("Failed to upload image. Error: ${response.reasonPhrase}");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (controller == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: Stack(
      children: [
        SizedBox(
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
              padding:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6),
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
                backgroundColor: const Color.fromARGB(255, 113, 212, 204),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40.0, vertical: 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                btn,
                style: const TextStyle(
                  color: Colors.white,
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
