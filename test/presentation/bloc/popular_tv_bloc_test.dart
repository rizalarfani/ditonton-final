import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_bloc_test.mocks.dart';

@GenerateMocks([GetPopularTvSeries])
void main() {
  late MockGetPopularTvSeries mockGetPopularTvSeries;
  late PopularTvBloc popularTvBloc;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvBloc = PopularTvBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  final tTvList = <TvSeries>[testTvSeries];

  test('initial state should be PopularTvInitial', () {
    expect(popularTvBloc.state, PopularTvInitial());
  });

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetPopularTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      PopularTvLoading(),
      PopularTvHastData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetPopularTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return popularTvBloc;
    },
    act: (bloc) => bloc.add(GetPopularTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      PopularTvLoading(),
      PopularTvError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetPopularTvSeries.execute());
    },
  );
}
