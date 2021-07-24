part of 'description_bloc.dart';

@immutable
abstract class DescriptionState extends Equatable {
  const DescriptionState();
}

class InitialDescriptionState extends DescriptionState {
  const InitialDescriptionState();

  @override
  List<Object?> get props => const [];
}

class LoadingDescriptionState extends DescriptionState {
  const LoadingDescriptionState();

  @override
  List<Object?> get props => const [];
}

class SuccessDescriptionState extends DescriptionState {
  final Reagent reagent;

  const SuccessDescriptionState({
    required this.reagent,
  });

  @override
  List<Reagent?> get props => [reagent];
}

class FailureDescriptionState extends DescriptionState {
  final Exception? exception;
  const FailureDescriptionState({
    this.exception,
  });

  @override
  List<Exception?> get props => [exception];
}
