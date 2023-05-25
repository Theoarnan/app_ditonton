import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
  }

  Future<void> clickSeeMorePopularMovies() async {
    final seePopularMoviesButtonFinder =
        find.byKey(const Key('seeMorePopularMovies'));
    await tester.ensureVisible(seePopularMoviesButtonFinder);
    await tester.tap(seePopularMoviesButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickSeeMoreTopRatedMovies() async {
    final seeTopRatedMoviesButtonFinder =
        find.byKey(const Key('seeMoreTopRatedMovies'));
    await tester.ensureVisible(seeTopRatedMoviesButtonFinder);
    await tester.tap(seeTopRatedMoviesButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickMovieItem({required String keyList}) async {
    final movieItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickSearchMovieButton() async {
    final searchButtonMovieFinder = find.byKey(const Key('searchButtonMovie'));
    await tester.ensureVisible(searchButtonMovieFinder);
    await tester.tap(searchButtonMovieFinder);
    await tester.pumpAndSettle();
  }
}
