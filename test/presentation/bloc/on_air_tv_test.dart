import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_air_tv_series.dart';
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_test.mocks.dart';

@GenerateMocks([GetOnAirTvSeries])
void main() {
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;
  late OnAirTvBloc onAirTvBloc;

  setUp(() {
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    onAirTvBloc = OnAirTvBloc(getOnAirTvSeries: mockGetOnAirTvSeries);
  });

  final tTvList = <TvSeries>[testTvSeries];

  test('initial state should be OnAirTvInitial', () {
    expect(onAirTvBloc.state, OnAirTvInitial());
  });

  blocTest<OnAirTvBloc, OnAirTvState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Right(tTvList));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(GetOnAirTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      OnAirTvLoading(),
      OnAirTvHastData(tTvList),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTvSeries.execute());
    },
  );

  blocTest<OnAirTvBloc, OnAirTvState>(
    'Should emit [Loading, Error] when data is gotten successfully',
    build: () {
      when(mockGetOnAirTvSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server failure')));
      return onAirTvBloc;
    },
    act: (bloc) => bloc.add(GetOnAirTv()),
    wait: const Duration(microseconds: 100),
    expect: () => [
      OnAirTvLoading(),
      OnAirTvError('Server failure'),
    ],
    verify: (bloc) {
      verify(mockGetOnAirTvSeries.execute());
    },
  );
}
