import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.dart';

void main() {
  late MovieTopRatedBloc movieTopRatedBloc;

  setUpAll(() {
    movieTopRatedBloc = MockMovieTopRatedBloc();
    registerFallbackValue(MockMovieTopRatedState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MovieTopRatedBloc>.value(
      value: movieTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('page should display progress bar when loading',
      (WidgetTester tester) async {
    when(() => movieTopRatedBloc.state).thenReturn(MoviesTopRatedLoading());

    final progressFinder = find.byType(CircularProgressIndicator);
    final centerFinder = find.byType(Center);

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(centerFinder, findsOneWidget);
    expect(progressFinder, findsOneWidget);
  });

  testWidgets('page should display when data is loaded',
      (WidgetTester tester) async {
    when(() => movieTopRatedBloc.state).thenReturn(
      MovieTopRatedHasData(tMovieList),
    );

    final listViewFinder = find.byType(ListView);
    final listViewKeyFinder = find.byKey(const Key('listTopRatedMovies'));
    final listViewContentFinder = find.byKey(const Key('listTopRatedMovies0'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(listViewFinder, findsOneWidget);
    expect(listViewKeyFinder, findsOneWidget);
    expect(listViewContentFinder, findsOneWidget);
  });

  testWidgets('page should display ilustration empty when state is empty',
      (WidgetTester tester) async {
    when(() => movieTopRatedBloc.state).thenReturn(
      MoviesTopRatedEmpty(),
    );

    final ilustrationFinder = find.byKey(const Key('emptyDataTopRatedMovie'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(ilustrationFinder, findsOneWidget);
  });

  testWidgets('Page should display text with message when Error',
      (WidgetTester tester) async {
    when(() => movieTopRatedBloc.state).thenReturn(
      const MoviesTopRatedError('Error Message'),
    );

    final textFinder = find.byKey(const Key('error_message'));

    await tester.pumpWidget(makeTestableWidget(const TopRatedMoviesPage()));

    expect(textFinder, findsOneWidget);
  });
}
