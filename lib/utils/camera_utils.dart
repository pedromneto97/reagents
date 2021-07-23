// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:google_ml_kit/google_ml_kit.dart';

class ScannerUtils {
  ScannerUtils._();

  static Future<CameraDescription> getCamera(CameraLensDirection dir) async {
    return availableCameras().then(
      (List<CameraDescription> cameras) => cameras.firstWhere(
        (CameraDescription camera) => camera.lensDirection == dir,
      ),
    );
  }

  static Uint8List concatenatePlanes(List<Plane> planes) {
    final WriteBuffer allBytes = WriteBuffer();
    for (Plane plane in planes) {
      allBytes.putUint8List(plane.bytes);
    }
    return allBytes.done().buffer.asUint8List();
  }

  static InputImageData buildMetaData(
    CameraImage image,
    InputImageRotation rotation,
  ) {
    return InputImageData(
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
  }

  static InputImageRotation rotationIntToImageRotation(int rotation) {
    return InputImageRotationMethods.fromRawValue(rotation) ??
        InputImageRotation.Rotation_0deg;
  }
}
