import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detecção de reagentes',
          textAlign: TextAlign.center,
        ),
        centerTitle: true,
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Bem vindo ao aplicativo de deteção de reagentes'),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(
                context,
                '/detect',
              ),
              child: Row(
                children: const [
                  Text('Começar'),
                  Icon(Icons.arrow_forward),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
            )
          ],
        ),
      ),
    );
  }
}
