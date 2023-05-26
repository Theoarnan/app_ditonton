import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailMovieRobot {
  final WidgetTester tester;
  DetailMovieRobot(this.tester);

  Future<void> scrollDetailMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('movieDetailScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickMovieToWatchlistButton() async {
    final movieWatchlistButtonFinder =
        find.byKey(const Key('moveButtonWatchlist'));
    await tester.ensureVisible(movieWatchlistButtonFinder);
    await tester.tap(movieWatchlistButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailMovie'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
