import 'package:bloc/bloc.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/movie.dart';

part 'movies_recomendation_event.dart';
part 'movies_recomendation_state.dart';

class MoviesRecomendationBloc
    extends Bloc<MoviesRecomendationEvent, MoviesRecomendationState> {
  final GetMovieRecommendations getMovieRecommendations;
  MoviesRecomendationBloc({required this.getMovieRecommendations})
      : super(MovieRecommendationEmpty()) {
    on<GetMovieRecommendation>((event, emit) async {
      emit(MovieRecommendationLoading());

      final results = await getMovieRecommendations.execute(event.id);

      results.fold((failure) {
        emit(MovieRecommendationError(failure.message));
      }, (data) {
        if (data.isNotEmpty) {
          emit(MovieRecommendationHasData(data));
        } else {
          emit(MovieRecommendationEmpty());
        }
      });
    });
  }
}
