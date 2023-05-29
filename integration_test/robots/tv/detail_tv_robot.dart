import 'package:app_ditonton/features/tvseries/presentation/pages/season_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/tv_detail_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DetailTvRobot {
  final WidgetTester tester;
  DetailTvRobot(this.tester);

  Future<void> scrollDetailTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvDetailScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byKey(const Key('content_detail_tv')), findsOneWidget);
      expect(find.byKey(const Key('tvDetailScrollView')), findsOneWidget);
      expect(find.byKey(const Key('tvButtonWatchlist')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeasonTvItem() async {
    final tvSeasonItemFinder = find.byKey(const Key('seasonList0'));
    await tester.ensureVisible(tvSeasonItemFinder);
    await tester.tap(tvSeasonItemFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(SeasonDetailPage), findsOneWidget);
    expect(find.byType(TvDetailPage), findsNothing);
  }

  Future<void> scrollSeasonDetailTvPage({bool scrollBack = false}) async {
    final scrollViewFinder = find.byKey(const Key('seasonTvDetailScrollView'));
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(1000, 0), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(
        find.byKey(const Key('seasonTvDetailScrollView')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('seasonList0')),
        findsOneWidget,
      );
    } else {
      await tester.fling(scrollViewFinder, const Offset(-1000, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollRecomendationDetailTvPage(
      {bool scrollBack = false}) async {
    final scrollViewFinder = find.byKey(
      const Key('recomendationTvDetailScrollView'),
    );
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(1000, 0), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(
        find.byKey(const Key('recomendationTvDetailScrollView')),
        findsOneWidget,
      );
      expect(
        find.byKey(const Key('recomendation0tv')),
        findsOneWidget,
      );
    } else {
      await tester.fling(scrollViewFinder, const Offset(-1000, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickTvAddToWatchlistButton() async {
    final tvWatchlistButtonFinder = find.byKey(const Key('tvButtonWatchlist'));
    await tester.ensureVisible(tvWatchlistButtonFinder);
    await tester.tap(tvWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> clickTvRemoveFromWatchlistButton() async {
    final tvWatchlistButtonFinder = find.byKey(
      const Key('tvButtonWatchlist'),
    );
    await tester.ensureVisible(tvWatchlistButtonFinder);
    await tester.tap(tvWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailTv'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> goBackToWatchlist() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailTv'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistTvPage), findsOneWidget);
    expect(find.byType(TvDetailPage), findsNothing);
    expect(find.byKey(const Key('emptyDataWatchlistTv')), findsOneWidget);
    expect(find.text('Empty data watchlist tv'), findsOneWidget);
  }
}
