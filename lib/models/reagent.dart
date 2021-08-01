import 'package:equatable/equatable.dart';

class UnReagent extends Equatable {
  final int unNumber;
  final String? riskNumber;

  const UnReagent({
    required this.unNumber,
    required this.riskNumber,
  });

  @override
  List<dynamic> get props => [unNumber, riskNumber];
}

class Reagent extends UnReagent {
  final String nameAndDescription;
  final String riskClass;
  final String? limit;

  const Reagent({
    required this.nameAndDescription,
    required int unNumber,
    required this.riskClass,
    String? riskNumber,
    this.limit,
  }) : super(
          unNumber: unNumber,
          riskNumber: riskNumber,
        );

  @override
  List<dynamic> get props => [
        ...super.props,
        nameAndDescription,
        riskClass,
        limit,
      ];
}
