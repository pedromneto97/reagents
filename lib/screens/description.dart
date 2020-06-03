import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:reagentdetection/models/reagent.dart';

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
      appBar: AppBar(
        title: Text("Reagente"),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text("Reagente A"),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Text("Texto bem grande"),
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
