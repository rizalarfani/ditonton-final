import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../provider/watchlist_movie_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlistMovies, GetWatchlistTvSeries])
void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchlistTvSeries mockGetWatchlistTvSeries;
  late WatchlistMovieBloc movieBloc;
  late WatchlistTvBloc tvBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchlistTvSeries = MockGetWatchlistTvSeries();
    movieBloc = WatchlistMovieBloc(getWatchlistMovies: mockGetWatchlistMovies);
    tvBloc = WatchlistTvBloc(getWatchlistTvSeries: mockGetWatchlistTvSeries);
  });

  final tTvList = <TvSeries>[testTvSeries];
  final tMovies = <Movie>[testMovie];

  group('Wathclist Tv Series', () {
    test('initial state should be WatchlistTvInitial', () {
      expect(tvBloc.state, WatchlistTvInitial());
    });

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Right(tTvList));
        return tvBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistTv()),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvHasData(tTvList),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );

    blocTest<WatchlistTvBloc, WatchlistTvState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistTvSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));
        return tvBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistTv()),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistTvLoading(),
        WatchlistTvError('Server failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistTvSeries.execute());
      },
    );
  });

  group('Wathclist Movies', () {
    test('initial state should be WatchlistMovieInitial', () {
      expect(movieBloc.state, WatchlistMovieInitial());
    });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Right(tMovies));
        return movieBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistMovie()),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );

    blocTest<WatchlistMovieBloc, WatchlistMovieState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetWatchlistMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server failure')));
        return movieBloc;
      },
      act: (bloc) => bloc.add(GetWatchlistMovie()),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistMovieLoading(),
        WatchlistMovieError('Server failure'),
      ],
      verify: (bloc) {
        verify(mockGetWatchlistMovies.execute());
      },
    );
  });
}
