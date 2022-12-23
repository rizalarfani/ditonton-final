import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';
import '../../domain/usecases/get_top_rated_movies.dart';
import '../../domain/usecases/get_now_playing_movies.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  final GetPopularMovies getPopularMovies;
  final GetTopRatedMovies getTopRatedMovies;

  MovieListBloc({
    required this.getNowPlayingMovies,
    required this.getPopularMovies,
    required this.getTopRatedMovies,
  }) : super(MovieListEmpty()) {
    on<GetNowPlayingListMovie>((event, emit) async {
      emit(MovieListLoading());

      final results = await getNowPlayingMovies.execute();

      results.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });

    on<GetPopularListMovie>((event, emit) async {
      emit(MovieListLoading());

      final results = await getPopularMovies.execute();

      results.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });

    on<GetTopRatedListMovie>((event, emit) async {
      emit(MovieListLoading());

      final results = await getTopRatedMovies.execute();

      results.fold((failure) {
        emit(MovieListError(failure.message));
      }, (data) {
        emit(MovieListHasData(data));
      });
    });
  }
}
