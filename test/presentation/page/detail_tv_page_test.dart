import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/tv_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/tv_recomenndation_bloc.dart';
import 'package:ditonton/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_tv_page_test.mocks.dart';

@GenerateMocks([TvDetailBloc, TvWatchlistBloc, TvRecomenndationBloc])
void main() {
  late MockTvDetailBloc mockTvDetailBloc;
  late MockTvWatchlistBloc mockTvWatchlistBloc;
  late MockTvRecomenndationBloc mockTvRecomenndationBloc;

  setUp(() {
    mockTvDetailBloc = MockTvDetailBloc();
    mockTvRecomenndationBloc = MockTvRecomenndationBloc();
    mockTvWatchlistBloc = MockTvWatchlistBloc();
  });

  Widget _makeTestableWidget(
    Widget body,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TvDetailBloc>(
          create: (context) => mockTvDetailBloc,
        ),
        BlocProvider<TvRecomenndationBloc>(
          create: (context) => mockTvRecomenndationBloc,
        ),
        BlocProvider<TvWatchlistBloc>(
          create: (context) => mockTvWatchlistBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when Tv Series not added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvRecomenndationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockTvDetailBloc.state).thenReturn(DetailTvInitial());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationEmpty());
    when(mockTvWatchlistBloc.state).thenReturn(TvWatchlistInitial());

    when(mockTvDetailBloc.state).thenReturn(DetailTvLoading());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationLoading());

    when(mockTvDetailBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(mockTvRecomenndationBloc.state)
        .thenReturn(TvRecomenndationHasData(<TvSeries>[testTvSeries]));

    when(mockTvWatchlistBloc.state).thenReturn(IsAddedtoWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
      _makeTestableWidget(
        TvSeriesDetailPage(id: 1),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when Tv Series is added to wathclist',
      (WidgetTester tester) async {
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvRecomenndationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockTvDetailBloc.state).thenReturn(DetailTvInitial());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationEmpty());
    when(mockTvWatchlistBloc.state).thenReturn(TvWatchlistInitial());

    when(mockTvDetailBloc.state).thenReturn(DetailTvLoading());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationLoading());

    when(mockTvDetailBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(mockTvRecomenndationBloc.state)
        .thenReturn(TvRecomenndationHasData(<TvSeries>[testTvSeries]));

    when(mockTvWatchlistBloc.state).thenReturn(IsAddedtoWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when added to watchlist',
      (WidgetTester tester) async {
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvRecomenndationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockTvDetailBloc.state).thenReturn(DetailTvInitial());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationEmpty());
    when(mockTvWatchlistBloc.state).thenReturn(TvWatchlistInitial());

    when(mockTvDetailBloc.state).thenReturn(DetailTvLoading());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationLoading());

    when(mockTvDetailBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(mockTvRecomenndationBloc.state)
        .thenReturn(TvRecomenndationHasData(<TvSeries>[testTvSeries]));

    when(mockTvWatchlistBloc.state).thenReturn(IsAddedtoWatchlist(false));

    when(mockTvWatchlistBloc.state)
        .thenReturn(WatchlistMessage('Added to Watchlist Tv Series'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Added to Watchlist Tv Series'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockTvDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvRecomenndationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockTvWatchlistBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockTvDetailBloc.state).thenReturn(DetailTvInitial());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationEmpty());
    when(mockTvWatchlistBloc.state).thenReturn(TvWatchlistInitial());

    when(mockTvDetailBloc.state).thenReturn(DetailTvLoading());
    when(mockTvRecomenndationBloc.state).thenReturn(TvRecomenndationLoading());

    when(mockTvDetailBloc.state).thenReturn(DetailTvHasData(testTvDetail));
    when(mockTvRecomenndationBloc.state)
        .thenReturn(TvRecomenndationHasData(<TvSeries>[testTvSeries]));

    when(mockTvWatchlistBloc.state).thenReturn(IsAddedtoWatchlist(false));

    when(mockTvWatchlistBloc.state).thenReturn(WatchlistMessage('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(TvSeriesDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
