import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistMovieRobot {
  final WidgetTester tester;
  WatchlistMovieRobot(this.tester);

  Future<void> scrollWatchlistMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('watchlistMovieScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.text('Watchlist Movies'), findsOneWidget);
      expect(find.byKey(const Key('watchlistMovieScrollView')), findsOneWidget);
      expect(find.byKey(const Key('watchlistMovie0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickMovieItemWatchlist() async {
    final movieItemFinder = find.byKey(const Key('watchlistMovie0'));
    await tester.ensureVisible(movieItemFinder);
    await tester.tap(movieItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistMoviesPage), findsNothing);
    expect(find.byType(MovieDetailPage), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(WatchlistMoviesPage), findsNothing);
    expect(find.byType(HomeMoviePage), findsOneWidget);
  }
}
