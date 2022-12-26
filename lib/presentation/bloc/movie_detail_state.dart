part of 'movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class DetailMovieInitial extends MovieDetailState {}

class DetailMovieEmpty extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class DetailMovieError extends MovieDetailState {
  final String message;

  DetailMovieError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailMovieHasData extends MovieDetailState {
  final MovieDetail results;

  DetailMovieHasData(this.results);

  @override
  List<Object> get props => [results];
}

// MovieWatchlist
abstract class MovieWatchlist extends Equatable {
  const MovieWatchlist();

  @override
  List<Object> get props => [];
}

class MovieWatchlistInitial extends MovieWatchlist {}

class IsAddedtoWatchlist extends MovieWatchlist {
  final bool isAddedtoWatchlist;

  IsAddedtoWatchlist(this.isAddedtoWatchlist);

  @override
  List<Object> get props => [isAddedtoWatchlist];
}

class WatchlistMessage extends MovieWatchlist {
  final String message;

  WatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
