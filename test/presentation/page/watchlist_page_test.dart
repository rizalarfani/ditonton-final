import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:ditonton/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:ditonton/presentation/pages/watchlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_page_test.mocks.dart';

@GenerateMocks([WatchlistMovieBloc, WatchlistTvBloc])
void main() {
  late MockWatchlistMovieBloc mockWatchlistMovieBloc;
  late MockWatchlistTvBloc mockWatchlistTvBloc;

  setUp(() {
    mockWatchlistMovieBloc = MockWatchlistMovieBloc();
    mockWatchlistTvBloc = MockWatchlistTvBloc();
  });

  final tTv = <TvSeries>[testTvSeries];
  final tMovies = <Movie>[testMovie];

  Widget _makeTestableWidget(Widget body) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<WatchlistMovieBloc>(
          create: (context) => mockWatchlistMovieBloc,
        ),
        BlocProvider<WatchlistTvBloc>(
          create: (context) => mockWatchlistTvBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Wathclist Movie', () {
    testWidgets('Page should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockWatchlistMovieBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMovieLoading()));
      when(mockWatchlistTvBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistTvLoading()));
      when(mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieLoading());
      when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'Page should display ListView when data is WatchlistMovieHasData',
        (WidgetTester tester) async {
      when(mockWatchlistTvBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistTvHasData(tTv)));
      when(mockWatchlistMovieBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMovieHasData(tMovies)));
      when(mockWatchlistMovieBloc.state)
          .thenReturn(WatchlistMovieHasData(tMovies));
      when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvHasData(tTv));

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'Page should display text with message when WatchlistMovieError',
        (WidgetTester tester) async {
      when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());
      when(mockWatchlistTvBloc.stream).thenAnswer((_) => Stream.empty());
      when(mockWatchlistMovieBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistMovieError('')));
      when(mockWatchlistTvBloc.stream)
          .thenAnswer((_) => Stream.value(WatchlistTvError('')));
      when(mockWatchlistMovieBloc.state).thenReturn(WatchlistMovieError(''));
      when(mockWatchlistTvBloc.state).thenReturn(WatchlistTvError(''));

      final textFinder = find.byKey(Key('error_message'));

      await tester.pumpWidget(_makeTestableWidget(WatchlistPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
