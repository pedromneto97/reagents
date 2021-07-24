import 'package:equatable/equatable.dart';

class Reagent extends Equatable {
  final String nameAndDescription;

  final int numberONU;

  final String riskClass;

  final String? riskNumber;

  final String? limit;

  const Reagent({
    required this.nameAndDescription,
    required this.numberONU,
    required this.riskClass,
    this.riskNumber,
    this.limit,
  });

  @override
  List<dynamic> get props => [
        nameAndDescription,
        numberONU,
        riskClass,
        riskNumber,
        limit,
      ];
}
