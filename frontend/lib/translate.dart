import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:async';

class TranslationPage extends StatefulWidget {
  @override
  _TranslationPageState createState() => _TranslationPageState();
}

class _TranslationPageState extends State<TranslationPage> {
  late CameraController _controller;
  late List<CameraDescription> _cameras;
  bool _isDetecting = false;

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      _cameras = cameras;
      _controller = CameraController(
        _cameras[0],
        ResolutionPreset.medium,
      );
      _controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        _startDetecting();
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startDetecting() {
    _controller.startImageStream((CameraImage image) {
      if (!_isDetecting) {
        _isDetecting = true;
        processImage(image).then((result) {
          setState(() {
            print(result);
          });
          _isDetecting = false;
        });
      }
    });
  }

  Future<String> processImage(CameraImage image) async {
    return "Hand landmarks detected";
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Camera with MediaPipe Hand Tracking'),
      ),
      body: Center(
        child: AspectRatio(
          aspectRatio: _controller.value.aspectRatio,
          child: CameraPreview(_controller),
        ),
      ),
    );
  }
}

