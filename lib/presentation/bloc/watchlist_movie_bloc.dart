import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_watchlist_movies.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc
    extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMovieBloc({required this.getWatchlistMovies})
      : super(WatchlistMovieInitial()) {
    on<GetWatchlistMovie>((event, emit) async {
      emit(WatchlistMovieLoading());
      final results = await getWatchlistMovies.execute();

      results.fold((failure) {
        emit(WatchlistMovieError(failure.message));
      }, (data) {
        emit(WatchlistMovieHasData(data));
      });
    });
  }
}
