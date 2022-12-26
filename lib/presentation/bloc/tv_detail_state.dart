part of 'tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class DetailTvInitial extends TvDetailState {}

class DetailTvEmpty extends TvDetailState {}

class DetailTvLoading extends TvDetailState {}

class DetailTvError extends TvDetailState {
  final String message;

  DetailTvError(this.message);

  @override
  List<Object> get props => [message];
}

class DetailTvHasData extends TvDetailState {
  final TvSeriesDetail results;

  DetailTvHasData(this.results);

  @override
  List<Object> get props => [results];
}

// MovieWatchlist
abstract class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object> get props => [];
}

class TvWatchlistInitial extends TvWatchlistState {}

class IsAddedtoWatchlist extends TvWatchlistState {
  final bool isAddedtoWatchlist;

  IsAddedtoWatchlist(this.isAddedtoWatchlist);

  @override
  List<Object> get props => [isAddedtoWatchlist];
}

class WatchlistMessage extends TvWatchlistState {
  final String message;

  WatchlistMessage(this.message);

  @override
  List<Object> get props => [message];
}
