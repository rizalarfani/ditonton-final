import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetWatchlistTvSeries getWatchlistTvSeries;

  WatchlistTvBloc({required this.getWatchlistTvSeries})
      : super(WatchlistTvInitial()) {
    on<GetWatchlistTv>((event, emit) async {
      emit(WatchlistTvLoading());
      final results = await getWatchlistTvSeries.execute();

      results.fold((failure) {
        emit(WatchlistTvError(failure.message));
      }, (data) {
        emit(WatchlistTvHasData(data));
      });
    });
  }
}
