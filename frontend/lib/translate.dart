import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;
import 'global.dart' as global;
import 'package:translator/translator.dart';

class TranslationPage extends StatefulWidget {
  @override
  TranslationPageState createState() => TranslationPageState();
}

class TranslationPageState extends State<TranslationPage> {
  final translator = GoogleTranslator();
  late Future<void> _initializeControllerFuture;
  late Timer time;
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

  loadCamera() {
    debugPrint("test");
    controller = CameraController(camera![1], ResolutionPreset.veryHigh);
    _initializeControllerFuture = controller!.initialize();
  }

  startTimer() {
    debugPrint("start");
    setState(() {
      debugPrint("hi");
      if (btn == "Start") {
        btn = "Stop";
        const Duration interval = Duration(seconds: 1);
        time = Timer.periodic(interval, (Timer t) async {
          await takePic();
        });
      } else {
        btn = "Start";
        time.cancel();
      }
    });
  }

  takePic() async {
    final XFile imageFile = await controller!.takePicture();
    File image = File(imageFile.path);
    getPredictions(image);
  }

  getPredictions(File image) async {
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://${global.ipv4}:8000/translate'));
    var file = await http.MultipartFile.fromPath('image', image.path);
    request.files.add(file);
    var response = await request.send();

    if (response.statusCode == 200) {
      setState(() {
        debugPrint(response.toString());
        // translator
        //   .translate(json, to: global.language)
        //   .then((result) {
        // output = result.text;
        //   });
      });
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
      alignment: Alignment.topCenter,
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
        )
      ],
    ));
  }
}
