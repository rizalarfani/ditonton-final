import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/presentation/bloc/on_air_tv_bloc.dart';
import 'package:ditonton/presentation/pages/on_air_tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'on_air_tv_page_test.mocks.dart';

@GenerateMocks([OnAirTvBloc])
void main() {
  late MockOnAirTvBloc mockOnAirTvBloc;

  setUp(() {
    mockOnAirTvBloc = MockOnAirTvBloc();
  });

  final tTv = <TvSeries>[testTvSeries];

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<OnAirTvBloc>(
      create: (context) => mockOnAirTvBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('Page should display center progress bar when loading',
      (WidgetTester tester) async {
    when(mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvLoading()));
    when(mockOnAirTvBloc.state).thenReturn(OnAirTvLoading());

    final progressBarFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvSeries()));

    expect(centerFinder, findsOneWidget);
    expect(progressBarFinder, findsOneWidget);
  });

  testWidgets('Page should display ListView when data is OnAirTvHastData',
      (WidgetTester tester) async {
    when(mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvHastData(tTv)));
    when(mockOnAirTvBloc.state).thenReturn(OnAirTvHastData(tTv));

    final listViewFinder = find.byType(ListView);

    await tester.pumpWidget(_makeTestableWidget(OnAirTvSeries()));

    expect(listViewFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when OnAirTvError',
      (WidgetTester tester) async {
    when(mockOnAirTvBloc.stream).thenAnswer((_) => Stream.empty());
    when(mockOnAirTvBloc.stream)
        .thenAnswer((_) => Stream.value(OnAirTvError('')));
    when(mockOnAirTvBloc.state).thenReturn(OnAirTvError(''));

    final centerFinder = find.byType(Center);
    final textFinder = find.byKey(Key('error_message'));

    await tester.pumpWidget(_makeTestableWidget(OnAirTvSeries()));

    expect(centerFinder, findsOneWidget);
    expect(textFinder, findsOneWidget);
  });
}
