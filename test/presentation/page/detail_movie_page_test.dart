import 'package:ditonton/presentation/bloc/movie_detail_bloc.dart';
import 'package:ditonton/presentation/bloc/movies_recomendation_bloc.dart';
import 'package:ditonton/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'detail_movie_page_test.mocks.dart';

@GenerateMocks([MovieDetailBloc, MoviesRecomendationBloc, MovieWatchlistBloc])
void main() {
  late MockMovieDetailBloc mockMovieDetailBloc;
  late MockMoviesRecomendationBloc mockMoviesRecomendationBloc;
  late MockMovieWatchlistBloc mockWatchlistMovieBloc;

  setUp(() {
    mockMovieDetailBloc = MockMovieDetailBloc();
    mockMoviesRecomendationBloc = MockMoviesRecomendationBloc();
    mockWatchlistMovieBloc = MockMovieWatchlistBloc();
  });

  Widget _makeTestableWidget(
    Widget body,
  ) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<MovieDetailBloc>(
          create: (context) => mockMovieDetailBloc,
        ),
        BlocProvider<MoviesRecomendationBloc>(
          create: (context) => mockMoviesRecomendationBloc,
        ),
        BlocProvider<MovieWatchlistBloc>(
          create: (context) => mockWatchlistMovieBloc,
        ),
      ],
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMoviesRecomendationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(DetailMovieInitial());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(mockWatchlistMovieBloc.state).thenReturn(MovieWatchlistInitial());

    when(mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    when(mockMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockWatchlistMovieBloc.state).thenReturn(IsAddedtoWatchlist(false));

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(
      _makeTestableWidget(
        MovieDetailPage(id: 1),
      ),
    );

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMoviesRecomendationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(DetailMovieInitial());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(mockWatchlistMovieBloc.state).thenReturn(MovieWatchlistInitial());

    when(mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    when(mockMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockWatchlistMovieBloc.state).thenReturn(IsAddedtoWatchlist(true));

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when added to watchlist',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMoviesRecomendationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(DetailMovieInitial());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(mockWatchlistMovieBloc.state).thenReturn(MovieWatchlistInitial());

    when(mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    when(mockMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockWatchlistMovieBloc.state).thenReturn(IsAddedtoWatchlist(false));

    when(mockWatchlistMovieBloc.state)
        .thenReturn(WatchlistMessage('Added to Watchlist Movie'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Added to Watchlist Movie'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockMovieDetailBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockMoviesRecomendationBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockWatchlistMovieBloc.stream).thenAnswer((_) => Stream.empty());

    when(mockMovieDetailBloc.state).thenReturn(DetailMovieInitial());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationEmpty());
    when(mockWatchlistMovieBloc.state).thenReturn(MovieWatchlistInitial());

    when(mockMovieDetailBloc.state).thenReturn(MovieDetailLoading());
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationLoading());

    when(mockMovieDetailBloc.state)
        .thenReturn(DetailMovieHasData(testMovieDetail));
    when(mockMoviesRecomendationBloc.state)
        .thenReturn(MovieRecommendationHasData(testMovieList));

    when(mockWatchlistMovieBloc.state).thenReturn(IsAddedtoWatchlist(false));

    when(mockWatchlistMovieBloc.state).thenReturn(WatchlistMessage('Failed'));

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(_makeTestableWidget(MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
  });
}
