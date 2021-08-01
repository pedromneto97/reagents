import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../services/preferences_service.dart';
import '../../widgets/button_text_with_icon/button_text_with_icon.dart';
import '../detect/detect.dart';
import '../onboarding/onboarding.dart';

class Home extends StatelessWidget {
  static const screenName = 'home_screen';

  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(
                      'Detecção de Reagentes',
                      style: Theme.of(context).textTheme.headline2,
                      textAlign: TextAlign.center,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40.0),
                      child: Text.rich(
                        const TextSpan(
                          text:
                              'Identificação de reagentes através da leitura do ',
                          children: [
                            TextSpan(
                              text: 'painel de segurança.',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        style: Theme.of(context).textTheme.subtitle1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        RepositoryProvider.of<PreferencesService>(context)
                                .getPreference(
                          key: PreferencesService.dontShowKey,
                        )
                            ? Detect.screenName
                            : Onboarding.screenName,
                      );
                    },
                    child: const ButtonTextWithIcon(
                      text: 'Detectar Reagente',
                      icon: Icons.camera_alt_outlined,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: OutlinedButton(
                      onPressed: () {},
                      child: const ButtonTextWithIcon(
                        text: 'Sobre',
                        icon: Icons.info_outline_rounded,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
