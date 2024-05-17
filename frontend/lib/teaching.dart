import 'dart:async';
import 'dart:convert';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:http/http.dart' as http;
import 'global.dart' as global;

class ModelUpdate extends StatefulWidget {
  const ModelUpdate({super.key});

  @override
  State<ModelUpdate> createState() => _ModelUpdateState();
}

class _ModelUpdateState extends State<ModelUpdate> {
  CameraImage? cameraImage;
  CameraController? controller;
  String output = "Translation";

  @override
  void initState() {
    super.initState();
    loadCamera();
  }

  loadCamera() {
    controller = CameraController(camera!.first, ResolutionPreset.veryHigh);
    controller!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          controller!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            // Timer.periodic(Duration(seconds: 1), (Timer t) {
            //   debugPrint("hi");
            // });
          });
        });
      }
    });
  }

  getPredictions(image) async {
    debugPrint(image);
    // List<int> imageBytes = await image.readAsBytes();
    // final resp =
    //     await http.post(Uri.parse('http://192.168.133.13:8000/translate'),body: );
    // if (resp.statusCode == 200) {
    //   setState(() {
    //     final Map<String, dynamic> json = jsonDecode(resp.body);
    //     debugPrint(json.toString());
    //   });
    // }
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          output,
          style: TextStyle(fontSize: 16, color: Colors.black),
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
        )
      ],
    ));
  }
}
