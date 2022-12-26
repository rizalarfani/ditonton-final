part of 'movies_recomendation_bloc.dart';

abstract class MoviesRecomendationState extends Equatable {
  const MoviesRecomendationState();

  @override
  List<Object> get props => [];
}

class MovieRecommendationEmpty extends MoviesRecomendationState {}

class MovieRecommendationLoading extends MoviesRecomendationState {}

class MovieRecommendationError extends MoviesRecomendationState {
  final String message;

  MovieRecommendationError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieRecommendationHasData extends MoviesRecomendationState {
  final List<Movie> movie;

  MovieRecommendationHasData(this.movie);

  @override
  List<Object> get props => [movie];
}
