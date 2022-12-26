import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tv_series_recommendation.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recomenndation_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
])
void main() {
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late TvDetailBloc tvDetailBloc;
  late TvRecomenndationBloc tvRecomenndationBloc;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    tvDetailBloc = TvDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
    tvRecomenndationBloc = TvRecomenndationBloc(
        getTvSeriesRecommendation: mockGetTvSeriesRecommendation);
  });

  final tId = 1;
  final tTvSeries = <TvSeries>[testTvSeries];

  group('Detail Tv Series', () {
    test('initial state should be DetailTvInitial', () {
      expect(tvDetailBloc.state, DetailTvInitial());
    });

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetDetailTv(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        DetailTvLoading(),
        DetailTvHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(GetDetailTv(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [DetailTvLoading(), DetailTvError('Server Failure')],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      },
    );
  });

  group('Recomenndation Tv Series', () {
    test('initial state should be TvRecomenndationInitial', () {
      expect(tvRecomenndationBloc.state, TvRecomenndationInitial());
    });

    blocTest<TvRecomenndationBloc, TvRecomenndationState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendation.execute(tId))
            .thenAnswer((_) async => Right(tTvSeries));
        return tvRecomenndationBloc;
      },
      act: (bloc) => bloc.add(GetTvRecomenndation(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        TvRecomenndationLoading(),
        TvRecomenndationHasData(tTvSeries),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendation.execute(tId));
      },
    );

    blocTest<TvRecomenndationBloc, TvRecomenndationState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockGetTvSeriesRecommendation.execute(tId))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return tvRecomenndationBloc;
      },
      act: (bloc) => bloc.add(GetTvRecomenndation(tId)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        TvRecomenndationLoading(),
        TvRecomenndationError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendation.execute(tId));
      },
    );
  });
}
