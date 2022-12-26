import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_reted_tv_series.dart';
import 'package:ditonton/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'top_rated_tv_bloc_test.mocks.dart';

@GenerateMocks([GetTopRaledTvSeries])
void main() {
  late MockGetTopRaledTvSeries mockGetTopRaledTvSeries;
  late TopRatedTvBloc topRatedTvBloc;

  setUp(() {
    mockGetTopRaledTvSeries = MockGetTopRaledTvSeries();
    topRatedTvBloc =
        TopRatedTvBloc(getTopRaledTvSeries: mockGetTopRaledTvSeries);
  });

  final tTvList = <TvSeries>[testTvSeries];

  test('initial state should be TopRatedTvInitial', () {
    expect(topRatedTvBloc.state, TopRatedTvInitial());
  });

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetTopRaledTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvHastData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetTopRaledTvSeries.execute());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetTopRaledTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return topRatedTvBloc;
    },
    act: (bloc) => bloc.add(GetTopRatedTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      TopRatedTvLoading(),
      TopRatedTvError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetTopRaledTvSeries.execute());
    },
  );
}
