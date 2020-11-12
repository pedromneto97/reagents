import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:hive/hive.dart';
import 'package:reagentdetection/models/reagent.dart';
import 'package:reagentdetection/utils/Scale.dart';

class Description extends StatefulWidget {
  final int numberOnu;
  final String riskNumber;

  const Description({Key key, this.numberOnu, this.riskNumber})
      : super(key: key);

  @override
  _DescriptionState createState() => _DescriptionState();
}

class _DescriptionState extends State<Description> {
  Reagent reagent;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white12,
      appBar: AppBar(
        title: Text("Reagente"),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
          horizontal: scale(36),
          vertical: verticalScale(29),
        ),
        child: Center(
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
                  horizontal: scale(3),
                  vertical: verticalScale(3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalScale(15),
                      ),
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Número de risco",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              this.reagent.riskNumber,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                        vertical: verticalScale(15),
                      ),
                      margin: EdgeInsets.all(0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black, width: 4.0),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Text(
                              "Número da ONU",
                              style: Theme.of(context).textTheme.headline4,
                            ),
                            Text(
                              this.reagent.numberONU.toString(),
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
                  horizontal: scale(3),
                  vertical: verticalScale(3),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    vertical: verticalScale(15),
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 4.0),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          "Número de Classe de Risco",
                          style: Theme
                              .of(context)
                              .textTheme
                              .headline4,
                        ),
                        Text(
                          this.reagent.riskClass,
                          style: Theme.of(context).textTheme.headline2,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  Container(
                    child: Image.asset(
                      'lib/assets/weight-hanging-solid.png',
                      height: verticalScale(74),
                    ),
                  ),
                  Column(
                    children: [
                      Text(
                        "Número de Classe de Risco",
                        style: Theme.of(context)
                            .textTheme
                            .headline4
                            .apply(color: Colors.white),
                      ),
                      Text(
                        this.reagent.limit + " KG",
                        style: Theme.of(context)
                            .textTheme
                            .headline2
                            .apply(color: Colors.white),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    Box<Reagent> box = Hive.box<Reagent>("onuBox");
    if (box.isOpen) {
      try {
        reagent = box.values.firstWhere(
              (element) =>
          element.numberONU == this.widget.numberOnu &&
              element.riskNumber == this.widget.riskNumber,
        );
      } catch (exception) {}
    } else {
      Hive.openBox<Reagent>("onuBox").then((value) {
        box = value;
        reagent = box.values.firstWhere(
              (element) =>
          element.numberONU == this.widget.numberOnu &&
              element.riskNumber == this.widget.riskNumber,
        );
      });
    }
  }
}
