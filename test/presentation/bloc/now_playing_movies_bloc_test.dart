import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'now_playing_movies_bloc_test.mocks.dart';

@GenerateMocks([GetNowPlayingMovies])
void main() {
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late NowPlayingMovieBloc nowPlayingMovieBloc;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc =
        NowPlayingMovieBloc(getNowPlayingMovies: mockGetNowPlayingMovies);
  });

  final tMovieList = <Movie>[testMovie];

  test('initial state should be empty', () {
    expect(nowPlayingMovieBloc.state, NowPlayingMoviesEmpty());
  });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingListMovie()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesHasData(tMovieList),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetNowPlayingMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return nowPlayingMovieBloc;
    },
    act: (bloc) => bloc.add(GetNowPlayingListMovie()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      NowPlayingMoviesLoading(),
      NowPlayingMoviesError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetNowPlayingMovies.execute());
    },
  );
}
