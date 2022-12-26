import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';
import '../../domain/usecases/get_popular_movies.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc({required this.getPopularMovies})
      : super(PopularMoviesEmpty()) {
    on<PopularMovieEvent>((event, emit) async {
      emit(PopularMoviesLoading());

      final results = await getPopularMovies.execute();

      results.fold((failure) {
        emit(PopularMoviesError(failure.message));
      }, (data) {
        emit(PopularMoviesHasData(data));
      });
    });
  }
}
