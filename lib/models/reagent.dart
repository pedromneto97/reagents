import 'package:hive/hive.dart';

part 'reagent.g.dart';

@HiveType(typeId: 0)
class Reagent {
  @HiveField(0)
  late final String nameAndDescription;

  @HiveField(1)
  late final int numberONU;

  @HiveField(2)
  late final String riskClass;

  @HiveField(3)
  late final String riskNumber;

  @HiveField(4)
  late final String limit;
}
