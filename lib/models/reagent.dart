import 'package:hive/hive.dart';

part './reagent.g.dart';

@HiveType(typeId: 0)
class Reagent {
  @HiveField(0)
  String nameAndDescription;

  @HiveField(1)
  int numberONU;

  @HiveField(2)
  String riskClass;

  @HiveField(3)
  String riskNumber;

  @HiveField(4)
  String limit;
}
