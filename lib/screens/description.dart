import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/reagent.dart';
import '../utils/scale.dart';

class Description extends StatefulWidget {
  final int numberOnu;
  final String riskNumber;

  const Description({
    Key? key,
    required this.numberOnu,
    required this.riskNumber,
  }) : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  late Reagent reagent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: const Text('Reagente'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 16,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              reagent.nameAndDescription,
              style: Theme.of(context).textTheme.headline3,
              textAlign: TextAlign.center,
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Número de risco',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            reagent.riskNumber,
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.black, width: 4.0),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            'Número da ONU',
                            style: Theme.of(context).textTheme.headline4,
                          ),
                          Text(
                            reagent.numberONU.toString(),
                            style: Theme.of(context).textTheme.headline2,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              color: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: 2,
                vertical: 2,
              ),
              child: Container(
                padding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 4.0),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Text(
                      'Número de Classe de Risco',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      reagent.riskClass,
                      style: Theme.of(context).textTheme.headline2,
                    ),
                  ],
                ),
              ),
            ),
            Row(
              children: [
                Image.asset(
                  'lib/assets/weight-hanging-solid.png',
                  height: verticalScale(74),
                ),
                Column(
                  children: [
                    Text(
                      'Número de Classe de Risco',
                      style: Theme.of(context)
                          .textTheme
                          .headline4!
                          .apply(color: Colors.white),
                    ),
                    Text(
                      reagent.limit + ' KG',
                      style: Theme.of(context)
                          .textTheme
                          .headline2!
                          .apply(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Box<Reagent> box = Hive.box<Reagent>('onuBox');
    print(box.isOpen);
    if (box.isOpen) {
      reagent = box.values.firstWhere(
        (element) =>
            element.numberONU == widget.numberOnu &&
            element.riskNumber == widget.riskNumber,
      );
    } else {
      Hive.openBox<Reagent>('onuBox').then((value) {
        box = value;
        reagent = box.values.firstWhere(
          (element) =>
              element.numberONU == widget.numberOnu &&
              element.riskNumber == widget.riskNumber,
        );
        setState(() {});
      });
    }
  }
}
