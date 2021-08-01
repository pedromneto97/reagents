import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../services/detect_service.dart';
import '../../utils/regex.dart';
import '../../widgets/clear_text_field_button/clear_text_field_button.dart';

class Detect extends StatefulWidget {
  const Detect({Key? key}) : super(key: key);

  @override
  _DetectState createState() => _DetectState();
}

class _DetectState extends State<Detect> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final riskNumberController = TextEditingController();
  final unNumberController = TextEditingController();
  final DetectService detectService = DetectService();
  CameraController? cameraController;
  bool isDetecting = false;

  void startDetecting() {
    cameraController!.startImageStream((CameraImage image) {
      if (isDetecting) {
        return;
      }
      isDetecting = true;
      detectService
          .detect(
        cameraImage: image,
        sensorOrientation: cameraController!.description.sensorOrientation,
      )
          .then((value) {
        if (value != null) {
          riskNumberController.text = value.riskNumber ?? '';
          unNumberController.text = value.unNumber.toString();
        }
      }).whenComplete(() => isDetecting = false);
    });
  }

  void listenUNNumber() {
    if (unNumberController.text.isEmpty) {
      startDetecting();
      return;
    }

    if (cameraController!.value.isStreamingImages) {
      cameraController!.stopImageStream();
    }
  }

  @override
  void initState() {
    super.initState();
    availableCameras()
        .then(
          (cameras) => cameras.firstWhere(
            (CameraDescription camera) =>
                camera.lensDirection == CameraLensDirection.back,
          ),
        )
        .then(onNewCameraSelected);
    unNumberController.addListener(listenUNNumber);
  }

  void onNewCameraSelected(CameraDescription description) {
    cameraController = CameraController(
      description,
      ResolutionPreset.ultraHigh,
      enableAudio: false,
    );

    cameraController!.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
      startDetecting();
    });
  }

  @override
  void dispose() {
    cameraController?.dispose();
    riskNumberController.dispose();
    unNumberController.removeListener(listenUNNumber);
    unNumberController.dispose();
    detectService.close();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController!.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      if (cameraController != null) {
        if (cameraController!.value.isStreamingImages) {
          cameraController!.stopImageStream();
        }
        cameraController!.dispose();
      }
    } else if (state == AppLifecycleState.resumed) {
      if (cameraController != null) {
        onNewCameraSelected(cameraController!.description);
      }
    }
  }

  String? validateRiskNumber(String? value) => !riskNumberRegex.hasMatch(value!)
      ? 'Não é um número de risco válido'
      : null;

  String? validateONUNumber(String? value) =>
      !unNumberRegex.hasMatch(value!) ? 'Não é um número da ONU válido' : null;

  navigate() {
    if (_formKey.currentState!.validate()) {
      Navigator.pushNamed(
        context,
        '/reagent',
        arguments: {
          'riskNumber': riskNumberController.text,
          'numberOnu': int.parse(unNumberController.text),
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Center(
                  child: cameraController?.buildPreview() ??
                      const CircularProgressIndicator(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 32,
                  right: 32,
                  top: 24,
                  bottom: 32,
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: 66,
                        child: TextFormField(
                          textInputAction: TextInputAction.next,
                          keyboardType: TextInputType.text,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'Número de Risco',
                            hintText: '1ª linha',
                            suffixIcon: ClearTextFieldButton(
                              controller: riskNumberController,
                            ),
                          ),
                          controller: riskNumberController,
                          validator: validateRiskNumber,
                          maxLength: 4,
                        ),
                      ),
                      Container(
                        height: 66,
                        margin: const EdgeInsets.only(
                          top: 4.0,
                          bottom: 24,
                        ),
                        child: TextFormField(
                          textInputAction: TextInputAction.done,
                          keyboardType: TextInputType.number,
                          textCapitalization: TextCapitalization.characters,
                          decoration: InputDecoration(
                            labelText: 'Número da ONU',
                            hintText: '2ª linha',
                            suffixIcon: ClearTextFieldButton(
                              controller: unNumberController,
                            ),
                          ),
                          maxLength: 4,
                          controller: unNumberController,
                          validator: validateONUNumber,
                          onFieldSubmitted: (_) => navigate(),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: OutlinedButton(
                                onPressed: Navigator.of(context).pop,
                                child: const Text('Voltar'),
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 12.0),
                              child: ElevatedButton(
                                onPressed: navigate,
                                child: const Text('Procurar'),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
