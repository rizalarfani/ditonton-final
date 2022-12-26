part of 'tv_detail_bloc.dart';

abstract class TvDetailEvent extends Equatable {
  const TvDetailEvent();

  @override
  List<Object> get props => [];
}

class GetDetailTv extends TvDetailEvent {
  final int id;
  GetDetailTv(this.id);

  @override
  List<Object> get props => [id];
}

class AddWatchlist extends TvDetailEvent {
  final TvSeriesDetail tvDetail;

  AddWatchlist(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveWatchlistMovie extends TvDetailEvent {
  final TvSeriesDetail tvDetail;

  RemoveWatchlistMovie(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class LoadWatchlistStatus extends TvDetailEvent {
  final int id;

  LoadWatchlistStatus(this.id);

  @override
  List<Object> get props => [id];
}
