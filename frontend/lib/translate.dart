import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:translator/translator.dart';

import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'global.dart' as global;

class TranslationPage extends StatefulWidget {
  @override
  TranslationPageState createState() => TranslationPageState();
}

class TranslationPageState extends State<TranslationPage> {
  final translator = GoogleTranslator();
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
    controller = CameraController(camera![1], ResolutionPreset.veryHigh);
    controller!.initialize();
  }

  Future<List<int>> _convertToJpeg(CameraImage image) async {
    List<int> bytes = await FlutterImageCompress.compressWithList(
      image.planes[0].bytes,
      minHeight: image.height,
      minWidth: image.width,
      quality: 90,
    );
    return bytes;
  }

  startTimer() {
    setState(() {
      if (btn == "Start") {
        btn = "Stop";
        controller!.startImageStream((images) async {
          List<int> jpegData = await _convertToJpeg(images);
          getPredictions(jpegData);
        });
      } else {
        btn = "Start";
        controller!.stopImageStream();
      }
    });
  }

  getPredictions(image) async {
    debugPrint("test");
    var uri = Uri.parse('http://${global.ipv4}:8000/translate');
    var request = http.MultipartRequest('POST', uri);
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    var resp = await request.send();
    if (resp.statusCode == 200) {
      setState(() {
        debugPrint("hi");
        // translator
        //   .translate(json, to: global.language)
        //   .then((result) {
        // output = result.text;
        //   });
      });
    } else {
      debugPrint(resp.statusCode.toString());
    }
  }

  Widget build(BuildContext context) {
    if (controller == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
    return Scaffold(
        body: Column(
      children: [
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
        Container(
          height: MediaQuery.of(context).size.height * 0.7,
          width: MediaQuery.of(context).size.width,
          child: !controller!.value.isInitialized
              ? Container()
              : AspectRatio(
                  aspectRatio: controller!.value.aspectRatio,
                  child: CameraPreview(controller!),
                ),
        ),
      ],
    ));
  }
}
