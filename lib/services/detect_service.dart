import 'dart:typed_data';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

import '../models/reagent.dart';
import '../utils/regex.dart';

class DetectService {
  final TextDetector textRecognizer = GoogleMlKit.vision.textDetector();

  DetectService();

  Future<UnReagent?> detect({
    required CameraImage cameraImage,
    required int sensorOrientation,
  }) async {
    final inputImage = _generateInputImage(
      sensorOrientation: sensorOrientation,
      cameraImage: cameraImage,
    );

    final processedImage = await textRecognizer.processImage(
      inputImage,
    );

    for (TextBlock block in processedImage.blocks) {
      if (block.lines.length == 2) {
        final String? firstLine = riskNumberRegex.stringMatch(
          block.lines.first.text,
        );
        final String? secondLine = unNumberRegex.stringMatch(
          block.lines.last.text,
        );
        if (firstLine != null && secondLine != null) {
          return UnReagent(
            unNumber: int.parse(secondLine),
            riskNumber: firstLine,
          );
        }
      }
    }
  }

  InputImage _generateInputImage({
    required CameraImage cameraImage,
    required int sensorOrientation,
  }) =>
      InputImage.fromBytes(
        bytes: _concatenatePlanes(cameraImage.planes),
        inputImageData: _buildMetaData(
          cameraImage,
          _rotationIntToImageRotation(
            sensorOrientation,
          ),
        ),
      );

  Uint8List _concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  InputImageData _buildMetaData(
    CameraImage image,
    InputImageRotation rotation,
  ) =>
      InputImageData(
        size: Size(
          image.width.toDouble(),
          image.height.toDouble(),
        ),
        imageRotation: rotation,
        inputImageFormat:
            InputImageFormatMethods.fromRawValue(image.format.raw) ??
                InputImageFormat.NV21,
        planeData: image.planes.map(
          (Plane plane) {
            return InputImagePlaneMetadata(
              bytesPerRow: plane.bytesPerRow,
              height: plane.height,
              width: plane.width,
            );
          },
        ).toList(
          growable: false,
        ),
      );

  InputImageRotation _rotationIntToImageRotation(int rotation) =>
      InputImageRotationMethods.fromRawValue(rotation) ??
      InputImageRotation.Rotation_0deg;

  void close() async {
    await textRecognizer.close();
  }
}
