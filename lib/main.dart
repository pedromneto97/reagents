import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'screens/screens.dart';
import 'theme/theme.dart';
import 'utils/my_bloc_observer.dart';

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
      theme: appTheme,
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
