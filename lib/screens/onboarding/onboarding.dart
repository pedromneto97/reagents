import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/preferences_service.dart';
import '../../widgets/security_panel/security_panel.dart';
import '../detect/detect.dart';
import 'widgets/dont_show_again_checkbox.dart';

class Onboarding extends StatefulWidget {
  static const screenName = 'onboarding_screen';

  const Onboarding({Key? key}) : super(key: key);

  @override
  State<Onboarding> createState() => _OnboardingState();
}

class _OnboardingState extends State<Onboarding> {
  bool dontShowAgain = false;

  void onValueChange(bool value) {
    dontShowAgain = value;
  }

  void onPressNext() async {
    await RepositoryProvider.of<PreferencesService>(context).setPreference(
      key: PreferencesService.dontShowKey,
      value: dontShowAgain,
    );
    Navigator.of(context).pushReplacementNamed(
      Detect.screenName,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Painel de Segurança',
                    style: Theme.of(context).textTheme.headline4,
                    textAlign: TextAlign.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: SecurityPanel(),
                        ),
                        Text(
                          '→ Nº de Risco\n→ Nº ONU',
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DontShowAgainCheckbox(
                  onChange: onValueChange,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: ElevatedButton(
                    onPressed: onPressNext,
                    child: const Text('Continuar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
