import 'package:flutter/material.dart';

import 'app.dart';
import 'initialize.dart';

void main() async {
  await initialize();

  runApp(const MyApp());
}
