import 'dart:async';

import 'package:camera/camera.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';
import 'package:flutter/material.dart';

import '../utils/CameraUtils.dart';

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  final firstLineController = TextEditingController();
  final secondLineController = TextEditingController();
  final secondLineFocusNode = FocusNode();
  final TextRecognizer textRecognizer =
      FirebaseVision.instance.textRecognizer();
  final onuNumberRegex = RegExp(
    r"\d{2,4}",
  );
  final riskNumberRegex = RegExp(
    r"(x\d{2,3})|\d{2,4}",
    caseSensitive: false,
  );
  CameraController cameraController;
  CameraDescription cameraDescription;
  bool found = false;
  bool isDetecting = false;

  Future<void> detectImage(FirebaseVisionImage image) async {
    final processedImage = await textRecognizer.processImage(image);
    for (TextBlock block in processedImage.blocks) {
      List<TextLine> lines = block.lines;
      if (lines.length == 2) {
        String firstLine = riskNumberRegex.stringMatch(lines.first.text);
        String secondLine = onuNumberRegex.stringMatch(lines[1].text);
        if (firstLine != null && secondLine != null) {
          cameraController?.stopImageStream();
          found = true;
          this.firstLineController.text = firstLine;
          this.secondLineController.text = secondLine;
        }
      }
    }
  }

  clear() {
    found = false;
    firstLineController.clear();
    secondLineController.clear();
    startDetecting();
  }

  void startDetecting() {
    cameraController.startImageStream((CameraImage image) {
      if (isDetecting || found) {
        return;
      }
      isDetecting = true;
      detectImage(FirebaseVisionImage.fromBytes(
        ScannerUtils.concatenatePlanes(image.planes),
        ScannerUtils.buildMetaData(
          image,
          ScannerUtils.rotationIntToImageRotation(
              this.cameraDescription.sensorOrientation),
        ),
      )).whenComplete(() => isDetecting = false);
    });
  }

  @override
  void initState() {
    super.initState();
    ScannerUtils.getCamera(CameraLensDirection.back).then((value) {
      cameraController = CameraController(value, ResolutionPreset.ultraHigh);
      this.cameraDescription = value;
      cameraController.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
        startDetecting();
      });
    });
  }

  @override
  void dispose() {
    cameraController?.stopImageStream();
    cameraController?.dispose();
    secondLineFocusNode.dispose();
    firstLineController.dispose();
    secondLineController.dispose();
    textRecognizer.close();
    super.dispose();
  }

  onSubmitFirstLine(v) => secondLineFocusNode.requestFocus();

  String validateFirstLine(String value) {
    if (value.length < 2) {
      return "É necessário pelo menos dois caracteres";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detectar'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ConstrainedBox(
              child: cameraController != null &&
                  cameraController.value.isInitialized
                  ? AspectRatio(
                aspectRatio: cameraController.value.aspectRatio * 1.3,
                child: CameraPreview(cameraController),
              )
                  : CircularProgressIndicator(),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2,
                minHeight: 50.0,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: 'Primeira linha',
                      hintText: 'Primeira linha da placa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    controller: firstLineController,
                    onFieldSubmitted: onSubmitFirstLine,
                    validator: validateFirstLine,
                    maxLength: 4,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    autovalidate: true,
                    focusNode: secondLineFocusNode,
                    textInputAction: TextInputAction.done,
                    keyboardType: TextInputType.number,
                    textCapitalization: TextCapitalization.characters,
                    decoration: InputDecoration(
                      labelText: 'Segunda linha',
                      hintText: 'Segunda linha da placa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    maxLength: 4,
                  ),
                ),
              ],
            ),
            found
                ? Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: clear,
                    child: Text("Limpar"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
                Container(
                  height: 50,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text("Procurar reagente"),
                    color: Colors.blue,
                    textColor: Colors.white,
                  ),
                ),
              ],
            )
                : Container(
              height: 50,
              child: RaisedButton(
                onPressed: () {},
                child: Text("Procurar reagente"),
                color: Colors.blue,
                textColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
