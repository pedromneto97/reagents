import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class Detect extends StatefulWidget {
  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> {
  CameraController controller;
  final firstLine = TextEditingController();
  final secondLine = TextEditingController();
  final secondLineFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    availableCameras().then((cameras) {
      print(cameras);
      controller = CameraController(cameras[0], ResolutionPreset.ultraHigh);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    secondLineFocusNode.dispose();
    firstLine.dispose();
    secondLine.dispose();
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
              child: controller != null && controller.value.isInitialized
                  ? AspectRatio(
                      aspectRatio: controller.value.aspectRatio * 1.3,
                      child: CameraPreview(controller),
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
                    controller: firstLine,
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
        ),
      ),
    );
  }
}
