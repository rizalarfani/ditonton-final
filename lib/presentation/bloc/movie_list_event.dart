part of 'movie_list_bloc.dart';

abstract class MovieListEvent extends Equatable {
  const MovieListEvent();

  @override
  List<Object> get props => [];
}

class GetNowPlayingListMovie extends MovieListEvent {}

class GetPopularListMovie extends MovieListEvent {}

class GetTopRatedListMovie extends MovieListEvent {}
