import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_event.dart';
part 'bottom_navigation_state.dart';

class BottomNavigationBloc
    extends Bloc<BottomNavigationEvent, BottomNavigationState> {
  BottomNavigationBloc() : super(CurrentIndex(0)) {
    on<ChangeCurrentIndex>((event, emit) {
      emit(CurrentIndex(event.index));
    });
  }
}
