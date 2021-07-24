import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../models/reagent.dart';
import '../../../services/onu_table_repository.dart';

part 'description_event.dart';
part 'description_state.dart';

class DescriptionBloc extends Bloc<DescriptionEvent, DescriptionState> {
  DescriptionBloc() : super(const InitialDescriptionState());

  final OnuTableRepository repository = OnuTableRepository();

  @override
  Stream<DescriptionState> mapEventToState(DescriptionEvent event) async* {
    if (event is GetDescriptionEvent) {
      yield const LoadingDescriptionState();
      try {
        final reagent = await repository.find(
          riskNumber: event.riskNumber,
          onuNumber: event.numberOnu,
        );

        yield SuccessDescriptionState(reagent: reagent);
      } on Exception catch (e) {
        yield FailureDescriptionState(exception: e);
      } catch (_) {
        yield const FailureDescriptionState();
      }
    }
  }
}
