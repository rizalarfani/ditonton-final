import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_now_playing_movies.dart';

part 'now_playing_movie_event.dart';
part 'now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;

  NowPlayingMovieBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMoviesEmpty()) {
    on<NowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMoviesLoading());

      final results = await getNowPlayingMovies.execute();

      results.fold((failure) {
        emit(NowPlayingMoviesError(failure.message));
      }, (data) {
        emit(NowPlayingMoviesHasData(data));
      });
    });
  }
}
