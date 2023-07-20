import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'navigator_event.dart';
part 'navigator_state.dart';

class NavigatorBloc extends Bloc<NavigatorEvent, NavigatorHomeState> {
  NavigatorBloc() : super(const NavigatorInitial(0)) {
    on<TabChangeEvent>(tabChangeEvent);
  }

  FutureOr<void> tabChangeEvent(
      TabChangeEvent event, Emitter<NavigatorHomeState> emit) {
    emit(NavigatorInitial(event.tabIndex));
  }
}
