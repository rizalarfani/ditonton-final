import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvDetailBloc({required this.getTvSeriesDetail}) : super(DetailTvInitial()) {
    on<GetDetailTv>((event, emit) async {
      emit(DetailTvLoading());
      final results = await getTvSeriesDetail.execute(event.id);

      results.fold((failure) {
        emit(DetailTvError(failure.message));
      }, (data) {
        emit(DetailTvHasData(data));
      });
    });
  }
}

class TvWatchlistBloc extends Bloc<TvDetailEvent, TvWatchlistState> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist Tv Series';
  static const watchlistRemoveSuccessMessage =
      'Removed from Watchlist Tv Series';

  TvWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(TvWatchlistInitial()) {
    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.executeTvSeries(event.tvDetail);

      await result.fold(
        (failure) async {
          emit(WatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMessage(successMessage));
        },
      );
    });

    on<RemoveWatchlistMovie>((event, emit) async {
      final result = await removeWatchlist.executeTvSeries(event.tvDetail);

      await result.fold(
        (failure) async {
          emit(WatchlistMessage(failure.message));
        },
        (successMessage) async {
          emit(WatchlistMessage(successMessage));
        },
      );
    });

    on<LoadWatchlistStatus>((event, emit) async {
      final result = await getWatchListStatus.execute(event.id);
      emit(IsAddedtoWatchlist(result));
    });
  }
}
