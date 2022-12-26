import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie_detail.dart';
import '../../domain/usecases/get_movie_detail.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({
    required this.getMovieDetail,
  }) : super(DetailMovieInitial()) {
    on<GetDetailMovie>((event, emit) async {
      emit(MovieDetailLoading());
      final results = await getMovieDetail.execute(event.id);

      results.fold((failure) {
        emit(DetailMovieError(failure.message));
      }, (data) {
        emit(DetailMovieHasData(data));
      });
    });
  }
}

class MovieWatchlistBloc extends Bloc<MovieDetailEvent, MovieWatchlist> {
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;

  static const watchlistAddSuccessMessage = 'Added to Watchlist Movie';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist Movie';

  MovieWatchlistBloc({
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  }) : super(MovieWatchlistInitial()) {
    on<AddWatchlist>((event, emit) async {
      final result = await saveWatchlist.execute(event.movie);

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
      final result = await removeWatchlist.execute(event.movie);

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
