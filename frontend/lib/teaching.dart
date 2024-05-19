import 'dart:async';
import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:frontend/main.dart';
import 'package:translator/translator.dart';

import 'package:http/http.dart' as http;
import 'global.dart' as global;

class ModelUpdate extends StatefulWidget {
  const ModelUpdate({super.key});

  @override
  ModelState createState() => ModelState();
}

class ModelState extends State<ModelUpdate> {
  final TextEditingController _word = TextEditingController();
  bool _wordValidate = false;
  final translator = GoogleTranslator();
  late Timer timer;
  bool isCapturing = false;
  var btn = "Start";

  CameraImage? cameraImage;
  CameraController? controller;
  String output = "";

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
    var apiUrl = Uri.parse('http://${global.ipv4}:3001/oneHand');
    var request = http.MultipartRequest('POST', apiUrl);
    request.files.add(
      await http.MultipartFile.fromPath(
        'image',
        imageFile.path,
      ),
    );
    var response = await request.send();
    if (response.statusCode == 200) {
      setState(() {
        setState(() {
          output = "Upload Successful";
        });
      });
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
        body: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextFormField(
              controller: _word,
              textAlignVertical: TextAlignVertical.center,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'word/letter/number',
                  alignLabelWithHint: true,
                  errorText: _wordValidate ? "Required Feild" : null,
                  isDense: true,
                  prefixIcon: Container(
                    margin: const EdgeInsets.only(right: 10),
                    decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 113, 212, 204),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(8.0),
                        bottomLeft: Radius.circular(8.0),
                      ),
                    ),
                    child: const Icon(Icons.email, color: Colors.white),
                  ),
                  contentPadding: const EdgeInsets.only(left: 10),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Color.fromARGB(255, 113, 212, 204), width: 2),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                  )),
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
      ],
    ));
  }
}
