import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailTvRobot {
  final WidgetTester tester;
  DetailTvRobot(this.tester);

  Future<void> scrollDetailTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvDetailScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 600), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -600), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeasonTvItem() async {
    final tvSeasonItemFinder = find.byKey(const Key('seasonList0'));
    await tester.ensureVisible(tvSeasonItemFinder);
    await tester.tap(tvSeasonItemFinder);
    await tester.pumpAndSettle();
  }

  Future<void> scrollSeasonDetailTvPage({bool scrollBack = false}) async {
    final scrollViewFinder = find.byKey(const Key('seasonTvDetailScrollView'));
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(600, 0), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(-600, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollRecomendationDetailTvPage({bool scrollUp = false}) async {
    final scrollViewFinder =
        find.byKey(const Key('recomendationTvDetailScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(600, 0), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(-600, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickTvToWatchlistButton() async {
    final tvWatchlistButtonFinder = find.byKey(const Key('tvButtonWatchlist'));
    await tester.ensureVisible(tvWatchlistButtonFinder);
    await tester.tap(tvWatchlistButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailTv'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
