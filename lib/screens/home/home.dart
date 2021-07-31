import 'package:flutter/material.dart';

class Home extends StatelessWidget {
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
                        style: Theme.of(context).textTheme.bodyText1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/detect',
                    ),
                    label: const Text(
                      'Detectar Reagente',
                    ),
                    icon: const Icon(
                      Icons.camera_alt_outlined,
                      size: 40,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 24.0),
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      label: const Text(
                        'Sobre',
                      ),
                      icon: const Icon(
                        Icons.info_outline_rounded,
                        size: 40,
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
