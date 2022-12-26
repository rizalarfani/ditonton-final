import 'package:ditonton/presentation/bloc/popular_movie_bloc.dart';
import 'package:ditonton/presentation/pages/popular_movies_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mocktail/mocktail.dart';

import 'popular_movie_page_test.mocks.dart';

@GenerateMocks([PopularMovieBloc])
class PopularMovieStateFake extends Fake implements PopularMovieState {}

void main() {
  late MockPopularMovieBloc mockPopularMovieBloc;

  setUp(() {
    mockPopularMovieBloc = MockPopularMovieBloc();
    registerFallbackValue(PopularMovieStateFake());
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularMovieBloc>.value(
      value: mockPopularMovieBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });
}
