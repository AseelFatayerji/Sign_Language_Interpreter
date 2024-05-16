import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ModelUpdate extends StatefulWidget {
  const ModelUpdate({super.key});

  @override
  State<ModelUpdate> createState() => _ModelUpdateState();
}

class _ModelUpdateState extends State<ModelUpdate> {
  final WebViewController _controller = WebViewController()
    ..loadHtmlString("""<!DOCTYPE html>
<html>
<head>
    <meta charset='utf-8'>
    <meta http-equiv='X-UA-Compatible' content='IE=edge'>
    <title>Page Title</title>
    <meta name='viewport' content='width=device-width, initial-scale=1'>
    <link rel='stylesheet' type='text/css' media='screen' href='main.css'>
    <script src='main.js'></script>
</head>
<body>
    <!-- Copyright 2023 The MediaPipe Authors.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

     http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License. -->
<link href="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.css" rel="stylesheet">
<script src="https://unpkg.com/material-components-web@latest/dist/material-components-web.min.js"></script>

<section id="demos" class="invisible">


<div id="liveView" class="videoView">
  <button id="webcamButton" class="mdc-button mdc-button--raised">
    <span class="mdc-button__ripple"></span>
    <span class="mdc-button__label">ENABLE WEBCAM</span>
  </button>
  <div style="position: relative;">
    <video id="webcam" autoplay playsinline></video>
    <canvas class="output_canvas" id="output_canvas" width="1280" height="720" style="position: absolute; left: 0px; top: 0px;"></canvas>
    <p id='gesture_output' class="output">
  </div>
</div>
</section>
</body>
</html>""");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: WebViewWidget(
        controller: _controller,
      )),
    );
  }
}
