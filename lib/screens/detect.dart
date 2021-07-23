import 'dart:async';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../utils/CameraUtils.dart';

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final firstLineController = TextEditingController();
  final secondLineController = TextEditingController();
  final secondLineFocusNode = FocusNode();
  final TextDetector textRecognizer = GoogleMlKit.vision.textDetector();
  final numberOnuRegex = RegExp(
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

  Future<void> detectImage(InputImage image) async {
    final processedImage = await textRecognizer.processImage(image);
    for (TextBlock block in processedImage.blocks) {
      List<TextLine> lines = block.lines;
      if (lines.length == 2) {
        String firstLine = riskNumberRegex.stringMatch(lines.first.text);
        String secondLine = numberOnuRegex.stringMatch(lines[1].text);
        if (firstLine != null && secondLine != null) {
          this.firstLineController.text = firstLine;
          this.secondLineController.text = secondLine;
          setState(() {
            found = true;
          });
          return;
        }
      }
    }
    startDetecting();
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
      detectImage(InputImage.fromBytes(
        bytes: ScannerUtils.concatenatePlanes(image.planes),
        inputImageData: ScannerUtils.buildMetaData(
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
      cameraController = CameraController(
        value,
        ResolutionPreset.ultraHigh,
        enableAudio: false,
      );
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
    cameraController?.dispose();
    secondLineFocusNode.dispose();
    firstLineController.dispose();
    secondLineController.dispose();
    textRecognizer.close();
    super.dispose();
  }

  onSubmitFirstLine(v) => secondLineFocusNode.requestFocus();

  String validateFirstLine(String value) => !riskNumberRegex.hasMatch(value)
      ? "Não é um número de risco válido"
      : null;

  String validateSecondLine(String value) =>
      !numberOnuRegex.hasMatch(value) ? "Não é um número da ONU válido" : null;

  navigate() {
    if (_formKey.currentState.validate()) {
      return Navigator.pushNamed(this.context, '/reagent', arguments: {
        "riskNumber": this.firstLineController.text,
        "numberOnu": int.parse(this.secondLineController.text),
      });
    }
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(
          'Existem campos inválidos',
          style: TextStyle(
              color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Colors.red[900],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
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
              child: cameraController?.buildPreview() ??
                  CircularProgressIndicator(),
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height / 2.5,
                minHeight: 50.0,
              ),
            ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      autovalidate: true,
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
                      controller: secondLineController,
                      validator: validateSecondLine,
                    ),
                  ),
                ],
              ),
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
                          onPressed: navigate,
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
                      onPressed: navigate,
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
