part of 'popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvEmpty extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvError extends PopularTvState {
  final String message;

  PopularTvError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularTvHastData extends PopularTvState {
  final List<TvSeries> results;

  PopularTvHastData(this.results);

  @override
  List<Object> get props => [results];
}
