import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reagentdetection/models/reagent.dart';
import 'package:reagentdetection/screens/screens.dart';
import 'package:reagentdetection/services/bootService.dart';

void main() async {
  runApp(MyApp());
  await Hive.initFlutter();
  Hive.registerAdapter(ReagentAdapter());
  initializeData();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detecção de reagentes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/detect': (context) => Detect(),
      },
    );
  }
}
