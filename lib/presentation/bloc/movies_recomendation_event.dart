part of 'movies_recomendation_bloc.dart';

abstract class MoviesRecomendationEvent extends Equatable {
  const MoviesRecomendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecommendation extends MoviesRecomendationEvent {
  final int id;

  const GetMovieRecommendation(this.id);

  @override
  List<Object> get props => [id];
}
