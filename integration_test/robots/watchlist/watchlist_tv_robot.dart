import 'dart:io';

import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/tv_detail_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class WatchlistTvRobot {
  final WidgetTester tester;
  WatchlistTvRobot(this.tester);

  Future<void> scrollWatchlistTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('watchlistTvScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.text('Watchlist Tv Series'), findsOneWidget);
      expect(find.byKey(const Key('watchlistTvScrollView')), findsOneWidget);
      expect(find.byKey(const Key('watchlistTv0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickTvItemWatchlist() async {
    final tvItemFinder = find.byKey(const Key('watchlistTv0'));
    await tester.ensureVisible(tvItemFinder);
    await tester.tap(tvItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistTvPage), findsNothing);
    expect(find.byType(TvDetailPage), findsOneWidget);
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(WatchlistTvPage), findsNothing);
    expect(find.byType(HomeTvPage), findsOneWidget);
  }
}
