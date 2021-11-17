import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/screens.dart';
import 'services/preferences_service.dart';
import 'theme/theme.dart';

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
          Onboarding.screenName: (context) => const Onboarding(),
        },
      ),
    );
  }
}
