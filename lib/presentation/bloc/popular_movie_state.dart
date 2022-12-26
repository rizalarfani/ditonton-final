part of 'popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMoviesEmpty extends PopularMovieState {}

class PopularMoviesLoading extends PopularMovieState {}

class PopularMoviesError extends PopularMovieState {
  final String message;

  PopularMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class PopularMoviesHasData extends PopularMovieState {
  final List<Movie> results;

  PopularMoviesHasData(this.results);

  @override
  List<Object> get props => [results];
}
