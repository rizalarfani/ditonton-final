import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/domain/usecases/save_watchlist.dart';
import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_recomendation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist
])
void main() {
  late MockGetMovieDetail mockGetMovieDetail;
  late MovieDetailBloc movieDetailBloc;
  late MoviesRecomendationBloc moviesRecomendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
    moviesRecomendationBloc = MoviesRecomendationBloc(
        getMovieRecommendations: mockGetMovieRecommendations);
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(
        getWatchListStatus: mockGetWatchListStatus,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  final tId = 1;
  final tMovies = <Movie>[testMovie];

  group('Detail Movie', () {
    test('initial state should be DetailMovieInitial', () {
      expect(movieDetailBloc.state, DetailMovieInitial());
    });

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(GetDetailMovie(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        MovieDetailLoading(),
        DetailMovieHasData(testMovieDetail),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetMovieDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(GetDetailMovie(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [MovieDetailLoading(), DetailMovieError('Server Failure')],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      },
    );
  });

  group('Recomenndation Movie', () {
    test('initial state should be MovieRecommendationEmpty', () {
      expect(moviesRecomendationBloc.state, MovieRecommendationEmpty());
    });

    blocTest<MoviesRecomendationBloc, MoviesRecomendationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Right(tMovies));
        return moviesRecomendationBloc;
      },
      act: (bloc) => bloc.add(GetMovieRecommendation(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationHasData(tMovies),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );

    blocTest<MoviesRecomendationBloc, MoviesRecomendationState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetMovieRecommendations.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return moviesRecomendationBloc;
      },
      act: (bloc) => bloc.add(GetMovieRecommendation(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        MovieRecommendationLoading(),
        MovieRecommendationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      },
    );
  });

  group('Watchlist movies', () {
    test('initial state should be MovieWatchlistInitial', () {
      expect(movieWatchlistBloc.state, MovieWatchlistInitial());
    });

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should get the watchlist status',
      build: () {
        when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(LoadWatchlistStatus(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        IsAddedtoWatchlist(true),
      ],
      verify: (bloc) {
        verify(mockGetWatchListStatus.execute(tId));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should update watchlist status when add watchlist success',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Added to Watchlist Movie'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistMessage('Added to Watchlist Movie'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );

    blocTest<MovieWatchlistBloc, MovieWatchlistState>(
      'should update watchlist message when add watchlist failed',
      build: () {
        when(mockSaveWatchlist.execute(testMovieDetail))
            .thenAnswer((_) async => Right('Failed'));
        return movieWatchlistBloc;
      },
      act: (bloc) => bloc.add(AddWatchlist(testMovieDetail)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        WatchlistMessage('Failed'),
      ],
      verify: (bloc) {
        verify(mockSaveWatchlist.execute(testMovieDetail));
      },
    );
  });
}
