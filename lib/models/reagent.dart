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

  Reagent.fromJson(Map<String, Object?> json)
      : this(
          nameAndDescription: json['nameAndDescription'] as String,
          unNumber: json['numberONU'] as int,
          riskClass: json['riskClass'] as String,
          limit: json['limit'] as String?,
          riskNumber: json['riskNumber'] as String?,
        );

  Map<String, dynamic> toJson() => {
        'nameAndDescription': nameAndDescription,
        'numberONU': unNumber,
        'riskClass': riskClass,
        'limit': limit,
        'riskNumber': riskNumber,
      };

  @override
  List<dynamic> get props => [
        ...super.props,
        nameAndDescription,
        riskClass,
        limit,
      ];
}
