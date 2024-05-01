import 'package:bloc/bloc.dart';

class AppBlocObserver extends BlocObserver {
  const AppBlocObserver();

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange(${bloc.runtimeType}, $change)');
  }

  @override
  void onError(BlocBase bloc, Object err, StackTrace trace) {
    super.onError(bloc, err, trace);
    print('onErr(${bloc.runtimeType}, $err, $trace})');
  }
}
