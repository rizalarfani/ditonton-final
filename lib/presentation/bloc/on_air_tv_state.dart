part of 'on_air_tv_bloc.dart';

abstract class OnAirTvState extends Equatable {
  const OnAirTvState();

  @override
  List<Object> get props => [];
}

class OnAirTvInitial extends OnAirTvState {}

class OnAirTvEmpty extends OnAirTvState {}

class OnAirTvLoading extends OnAirTvState {}

class OnAirTvError extends OnAirTvState {
  final String message;

  OnAirTvError(this.message);

  @override
  List<Object> get props => [message];
}

class OnAirTvHastData extends OnAirTvState {
  final List<TvSeries> results;

  OnAirTvHastData(this.results);

  @override
  List<Object> get props => [results];
}
