import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:reagentdetection/models/reagent.dart';

void initializeData() async {
  final box = await Hive.openBox<Reagent>("onuBox");
  if (box.isEmpty) {
    final jsonData = await rootBundle
        .loadString("lib/assets/onu_table.json")
        .then((value) => jsonDecode(value));
    final List<Reagent> reagentList = [];
    for (var item in jsonData) {
      final Reagent reagent = Reagent()
        ..nameAndDescription = item["nameAndDescription"]
        ..numberONU = item["numberONU"]
        ..riskClass = item["riskClass"]
        ..riskNumber = item["riskNumber"]
        ..limit = item["limit"];
      reagentList.add(reagent);
    }
    box.addAll(reagentList);
  }
}
