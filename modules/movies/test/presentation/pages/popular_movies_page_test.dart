import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.dart';

void main() {
  late MoviePopularBloc moviePopularBloc;

  setUpAll(() {
    // movie popular
    moviePopularBloc = MockMoviePopularBloc();
    registerFallbackValue(MockMoviePopularState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<MoviePopularBloc>.value(
      value: moviePopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page popular movie', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state).thenReturn(MoviesPopularLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display ListView when data is loaded',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state).thenReturn(
        MoviePopularHasData(tMovieList),
      );

      final listViewFinder = find.byType(ListView);
      final listViewKeyFinder = find.byKey(const Key('listPopularMovies'));
      final listViewContentFinder = find.byKey(const Key('listPopularMovies0'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(listViewFinder, findsOneWidget);
      expect(listViewKeyFinder, findsOneWidget);
      expect(listViewContentFinder, findsOneWidget);
    });

    testWidgets('should display ilustration empty when state is empty',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state).thenReturn(
        MoviesPopularEmpty(),
      );

      final ilustrationFinder = find.byKey(const Key('emptyDataPopularMovie'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(ilustrationFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(() => moviePopularBloc.state).thenReturn(
        const MoviesPopularError('Error Message'),
      );

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
