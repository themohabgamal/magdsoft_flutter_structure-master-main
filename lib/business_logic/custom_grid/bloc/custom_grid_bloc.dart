import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'custom_grid_event.dart';
part 'custom_grid_state.dart';

class CustomGridBloc extends Bloc<CustomGridEvent, CustomGridState> {
  CustomGridBloc() : super(CustomGridInitial()) {
    on<NavigateToProductScreenEvent>(navigateToProductScreenEvent);
  }

  FutureOr<void> navigateToProductScreenEvent(
      NavigateToProductScreenEvent event, Emitter<CustomGridState> emit) {
    emit(NavigateToProductScreenState());
  }
}
