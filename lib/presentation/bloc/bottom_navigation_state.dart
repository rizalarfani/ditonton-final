part of 'bottom_navigation_bloc.dart';

abstract class BottomNavigationState extends Equatable {
  const BottomNavigationState();

  @override
  List<Object> get props => [];
}

class BottomNavigationInitial extends BottomNavigationState {}

class CurrentIndex extends BottomNavigationState {
  final int index;

  CurrentIndex(this.index);

  @override
  List<Object> get props => [index];
}
