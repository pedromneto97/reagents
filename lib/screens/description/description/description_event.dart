part of 'description_bloc.dart';

@immutable
abstract class DescriptionEvent extends Equatable {
  const DescriptionEvent();
}

class GetDescriptionEvent extends DescriptionEvent {
  final int numberOnu;
  final String riskNumber;

  const GetDescriptionEvent({
    required this.numberOnu,
    required this.riskNumber,
  });

  @override
  List<dynamic> get props => [numberOnu, riskNumber];
}
