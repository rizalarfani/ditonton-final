import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/search_tv_series.dart';
import 'package:ditonton/presentation/bloc/search_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/search_tv_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_tv_bloc_test.mocks.dart';

@GenerateMocks([SearchTvSeries])
void main() {
  late SearchTvBloc searchTvBloc;
  late MockSearchTvSeries mockSearchTvSeries;

  setUp(() {
    mockSearchTvSeries = MockSearchTvSeries();
    searchTvBloc = SearchTvBloc(mockSearchTvSeries);
  });

  group('Search Tv Series Test', () {
    test('initial state should be empty', () {
      expect(searchTvBloc.state, SearchEmpty());
    });

    final tTvList = <TvSeries>[testTvSeries];
    final tQuery = 'name';

    blocTest<SearchTvBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Right(tTvList));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      wait: const Duration(microseconds: 100),
      expect: () => [
        SearchLoading(),
        SearchHasDataTv(tTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );

    blocTest<SearchTvBloc, SearchState>(
      'Should emit [Loading, Error] when data is gotten successfully',
      build: () {
        when(mockSearchTvSeries.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return searchTvBloc;
      },
      act: (bloc) => bloc.add(OnQueryChanged(tQuery)),
      expect: () => [
        SearchLoading(),
        SearchError('Server Failure'),
      ],
      verify: (bloc) {
        verify(mockSearchTvSeries.execute(tQuery));
      },
    );
  });
}
