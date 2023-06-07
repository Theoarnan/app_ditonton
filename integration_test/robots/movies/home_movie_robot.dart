import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';

class HomeMovieRobot {
  final WidgetTester tester;
  HomeMovieRobot(this.tester);

  Future<void> scrollMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('movieScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }

    /// expected
    expect(find.text('Now Playing'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byKey(const Key('nowplaying')), findsOneWidget);
    expect(find.byKey(const Key('popular')), findsOneWidget);
    expect(find.byKey(const Key('toprated')), findsOneWidget);
  }

  Future<void> clickSeeMorePopularMovies() async {
    final seePopularMoviesButtonFinder = find.byKey(
      const Key('seeMorePopularMovies'),
    );
    await tester.ensureVisible(seePopularMoviesButtonFinder);
    await tester.tap(seePopularMoviesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(PopularMoviesPage), findsOneWidget);
    expect(find.text('Popular Movies'), findsOneWidget);
    expect(find.byKey(const Key('listPopularMovies')), findsOneWidget);
  }

  Future<void> clickSeeMoreTopRatedMovies() async {
    final seeTopRatedMoviesButtonFinder =
        find.byKey(const Key('seeMoreTopRatedMovies'));
    await tester.ensureVisible(seeTopRatedMoviesButtonFinder);
    await tester.tap(seeTopRatedMoviesButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(TopRatedMoviesPage), findsOneWidget);
    expect(find.text('Top Rated Movies'), findsOneWidget);
    expect(find.byKey(const Key('listTopRatedMovies')), findsOneWidget);
  }

  Future<void> clickMovieItem({required String keyList}) async {
    final movieItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(MovieDetailPage), findsOneWidget);
  }

  Future<void> clickSearchMovieButton() async {
    final searchButtonMovieFinder = find.byKey(const Key('searchButtonMovie'));
    await tester.ensureVisible(searchButtonMovieFinder);
    await tester.tap(searchButtonMovieFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(SearchMoviePage), findsOneWidget);
    expect(find.text('Search Movies'), findsOneWidget);
    expect(find.byKey(const Key('enterSearchQueryMovie')), findsOneWidget);
    expect(find.byKey(const Key('list_search_movie')), findsNothing);
    expect(find.byKey(const Key('emptyDataSearchMovie')), findsOneWidget);
    expect(find.text('Search movie'), findsOneWidget);
  }
}
