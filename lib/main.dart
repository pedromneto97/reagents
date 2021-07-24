import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'utils/my_bloc_observer.dart';
import 'utils/scale.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
  ]);
  if (kDebugMode) Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Detecção de reagentes',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText1: const TextStyle(
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
          subtitle1: const TextStyle(
            color: Colors.black,
            fontFamily: 'ArialRoundedMT',
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            primary: Colors.blue,
            onPrimary: Colors.white,
            onSurface: Colors.blue,
            fixedSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            primary: Colors.blue,
            onSurface: Colors.blue,
            fixedSize: const Size.fromHeight(40),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            side: const BorderSide(
              color: Colors.blue,
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/detect': (context) => const Detect(),
        '/reagent': (context) {
          final Map<String, dynamic> args = ModalRoute.of(context)!
              .settings
              .arguments as Map<String, dynamic>;
          return Description(
            numberOnu: args['numberOnu'],
            riskNumber: args['riskNumber'],
          );
        },
      },
    );
  }
}
