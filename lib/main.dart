import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:reagentdetection/models/reagent.dart';
import 'package:reagentdetection/screens/screens.dart';
import 'package:reagentdetection/services/bootService.dart';
import 'package:reagentdetection/utils/Scale.dart';

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
        textTheme: TextTheme(
          bodyText1: TextStyle(
            color: Colors.black,
            fontFamily: 'ArialRoundedMT',
          ),
          headline2: TextStyle(
            color: Colors.black,
            fontSize: scaleFont(40),
            fontWeight: FontWeight.bold,
            fontFamily: 'ArialRoundedMT',
          ),
          headline3: TextStyle(
            color: Colors.white,
            fontSize: scaleFont(26),
            wordSpacing: 0,
            letterSpacing: 0,
            fontWeight: FontWeight.w700,
            fontFamily: 'ArialRoundedMT',
          ),
          headline4: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: scaleFont(20),
            fontFamily: 'ArialRoundedMT',
          ),
          headline5: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: scaleFont(20),
            fontFamily: 'ArialRoundedMT',
          ),
          headline6: TextStyle(
            color: Colors.white,
            fontSize: scaleFont(26),
            fontFamily: 'ArialRoundedMT',
          ),
          subtitle1: TextStyle(
            color: Colors.black,
            fontFamily: 'ArialRoundedMT',
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/detect': (context) => Detect(),
        '/reagent': (context) {
          final Map<String, dynamic> args =
              ModalRoute.of(context).settings.arguments;
          return Description(
            numberOnu: args["numberOnu"],
            riskNumber: args["riskNumber"],
          );
        },
      },
    );
  }
}
