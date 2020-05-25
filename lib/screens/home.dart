import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Detecção de reagentes",
          textAlign: TextAlign.center,
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Bem vindo ao aplicativo de deteção de reagentes"),
            RaisedButton(
              onPressed: () {},
              child: Row(
                children: [
                  Text("Começar"),
                  Icon(Icons.arrow_forward),
                ],
                mainAxisSize: MainAxisSize.min,
              ),
              color: Colors.blue,
              textColor: Colors.white,
            )
          ],
        ),
      ),
    );
  }
}
