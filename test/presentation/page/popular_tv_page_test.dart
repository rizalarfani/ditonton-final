import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/popular_tv_bloc.dart';
import 'package:ditonton/presentation/pages/popular_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'popular_tv_page_test.mocks.dart';

@GenerateMocks([PopularTvBloc])
void main() {
  late MockPopularTvBloc mockPopularTvBloc;

  setUp(() {
    mockPopularTvBloc = MockPopularTvBloc();
  });

  final tTv = <TvSeries>[testTvSeries];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<PopularTvBloc>(
      create: (context) => mockPopularTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvLoading()));
    when(mockPopularTvBloc.state).thenReturn(PopularTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeries()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is PopularTvHastData',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvHastData(tTv)));
    when(mockPopularTvBloc.state).thenReturn(PopularTvHastData(tTv));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeries()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when PopularTvError',
      (WidgetTester tester) async {
    when(mockPopularTvBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockPopularTvBloc.stream)
        .thenAnswer((_) => Stream.value(PopularTvError('')));
    when(mockPopularTvBloc.state).thenReturn(PopularTvError(''));

    final centerFinder = find.byType(Center);
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(PopularTvSeries()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
