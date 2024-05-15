import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:frontend/main.dart';
import 'package:tensorflow_lite_flutter/tensorflow_lite_flutter.dart';
import 'package:flutter_mediapipe/flutter_mediapipe.dart';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  CameraImage? cameraImage;
  CameraController? controller;
  String output = 'Translation';

  @override
  void initState() {
    super.initState();
    loadCamera();
    loadModel();
  }

  loadCamera() {
    controller = CameraController(cameras![0], ResolutionPreset.medium);
    controller!.initialize().then((value) {
      if (!mounted) {
        return;
      } else {
        setState(() {
          controller!.startImageStream((ImageStream) {
            cameraImage = ImageStream;
            runModel();
          });
        });
      }
    });
  }

  runModel() async {
    if (cameraImage != null) {
      var prediction = await Tflite.runModelOnFrame(
        bytesList: cameraImage!.planes.map((plane) {
          return plane.bytes;
        }).toList(),
        imageHeight: cameraImage!.height,
        imageWidth: cameraImage!.width,
        imageMean: 127.5,
        imageStd: 127.5,
        rotation: 90,
        numResults: 2,
        threshold: 0.1,
        asynch: true,
      );
      prediction!.forEach((element) {
        setState(() {
          output = element['label'];
        });
      });
    }
  }

  loadModel() async {
    await Tflite.loadModel(
        model: "assets/model/model.tflite", labels: "assets/model/label.txt");
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(height: 10),
        Text(output,
            style: const TextStyle(
              color: Colors.white60,
              backgroundColor: Colors.black38,
              fontSize: 18,
            )),
        const SizedBox(height: 10),
        Padding(
            padding: const EdgeInsets.all(10),
            child: Container(
              height: MediaQuery.of(context).size.height*0.7,
              width: MediaQuery.of(context).size.width,
              child: !controller!.value.isInitialized
                  ? Container()
                  : AspectRatio(
                      aspectRatio: controller!.value.aspectRatio,
                      child: CameraPreview(controller!),
                    ),
            ))
      ]),
    );
  }
}
