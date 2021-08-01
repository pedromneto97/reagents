import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/screens.dart';
import 'services/preferences_service.dart';
import 'theme/colors.dart' show grey;
import 'theme/theme.dart';
import 'utils/my_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    Firebase.initializeApp(),
    Hive.initFlutter(),
  ]);

  if (kDebugMode) Bloc.observer = MyBlocObserver();

  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      statusBarColor: grey.withOpacity(0.5),
      statusBarBrightness: Brightness.light,
      statusBarIconBrightness: Brightness.light,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => PreferencesService(),
      lazy: false,
      child: MaterialApp(
        title: 'Detecção de reagentes',
        theme: appTheme,
        initialRoute: Home.screenName,
        routes: {
          Home.screenName: (context) => const Home(),
          Detect.screenName: (context) => const Detect(),
          '/reagent': (context) {
            final Map<String, dynamic> args = ModalRoute.of(context)!
                .settings
                .arguments as Map<String, dynamic>;
            return Description(
              numberOnu: args['numberOnu'],
              riskNumber: args['riskNumber'],
            );
          },
          Onboarding.screenName: (context) => Onboarding(),
        },
      ),
    );
  }
}
