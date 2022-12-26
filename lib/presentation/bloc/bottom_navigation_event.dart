part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationEvent extends Equatable {
  const BottomNavigationEvent();

  @override
  List<Object> get props => [];
}

class ChangeCurrentIndex extends BottomNavigationEvent {
  final int index;

  ChangeCurrentIndex(this.index);

  @override
  List<Object> get props => [index];
}
