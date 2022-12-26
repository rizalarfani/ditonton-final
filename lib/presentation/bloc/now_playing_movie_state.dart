part of 'now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMoviesEmpty extends NowPlayingMovieState {}

class NowPlayingMoviesLoading extends NowPlayingMovieState {}

class NowPlayingMoviesError extends NowPlayingMovieState {
  final String message;

  NowPlayingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}

class NowPlayingMoviesHasData extends NowPlayingMovieState {
  final List<Movie> results;

  NowPlayingMoviesHasData(this.results);

  @override
  List<Object> get props => [results];
}
