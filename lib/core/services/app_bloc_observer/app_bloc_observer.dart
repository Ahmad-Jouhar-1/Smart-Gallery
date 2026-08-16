// ignore_for_file: avoid_print

import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('😄 Created : ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('🫨 ${bloc.runtimeType} Changed : $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    print('🤬 ${bloc.runtimeType} Error : $error');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('😴 Closed : ${bloc.runtimeType}');
  }
}
