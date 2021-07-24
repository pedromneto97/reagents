import 'dart:developer';

import 'package:bloc/bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('onCreate -- ${bloc.runtimeType}', name: 'BLOC');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('onChange -- ${bloc.runtimeType}, $change', name: 'BLOC');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('onError -- ${bloc.runtimeType}, $error', name: 'BLOC');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('onClose -- ${bloc.runtimeType}', name: 'BLOC');
  }
}
