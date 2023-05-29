import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:app_ditonton/presentation/pages/home_movie_page.dart';
import 'package:app_ditonton/presentation/pages/movie_detail_page.dart';
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

      /// expected
      expect(find.byKey(const Key('content_detail_movie')), findsOneWidget);
      expect(find.byKey(const Key('movieDetailScrollView')), findsOneWidget);
      expect(find.byKey(const Key('moveButtonWatchlist')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> scrollRecomendationMovieDetailPage({
    bool scrollBack = false,
  }) async {
    final scrollViewFinder = find.byKey(
      const Key('content_movie_detail_recommendation'),
    );
    if (scrollBack) {
      await tester.fling(scrollViewFinder, const Offset(1000, 0), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(
        find.byKey(const Key('content_movie_detail_recommendation')),
        findsOneWidget,
      );
    } else {
      await tester.fling(scrollViewFinder, const Offset(-1000, 0), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickMovieAddToWatchlistButton() async {
    final movieWatchlistButtonFinder = find.byKey(
      const Key('moveButtonWatchlist'),
    );
    await tester.ensureVisible(movieWatchlistButtonFinder);
    await tester.tap(movieWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.add), findsNothing);
    expect(find.byIcon(Icons.check), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> clickMovieRemoveFromWatchlistButton() async {
    final movieWatchlistButtonFinder = find.byKey(
      const Key('moveButtonWatchlist'),
    );
    await tester.ensureVisible(movieWatchlistButtonFinder);
    await tester.tap(movieWatchlistButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byIcon(Icons.check), findsNothing);
    expect(find.byIcon(Icons.add), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailMovie'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsOneWidget);
    expect(find.byType(MovieDetailPage), findsNothing);
  }

  Future<void> goBackToWatchlist() async {
    final backButtonFinder = find.byKey(const Key('buttonBackDetailMovie'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(WatchlistMoviesPage), findsOneWidget);
    expect(find.byType(MovieDetailPage), findsNothing);
    expect(find.byKey(const Key('emptyDataWatchlistMovie')), findsOneWidget);
    expect(find.text('Empty data watchlist movie'), findsOneWidget);
  }
}
