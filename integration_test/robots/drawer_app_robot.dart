import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:app_ditonton/features/watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:app_ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class DrawerAppRobot {
  final WidgetTester tester;
  DrawerAppRobot(this.tester);

  Future<void> clickNavigationDrawerButtonMovie() async {
    final drawerButtonFinder = find.byKey(const Key('drawerButtonMovie'));
    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('contentDrawer')), findsOneWidget);
    expect(find.byKey(const Key('movieListTile')), findsOneWidget);
    expect(find.byKey(const Key('watchlistListTile')), findsOneWidget);
  }

  Future<void> clickNavigationDrawerButtonTv() async {
    final drawerButtonFinder = find.byKey(const Key('drawerButtonTv'));
    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('contentDrawer')), findsOneWidget);
    expect(find.byKey(const Key('tvListTile')), findsOneWidget);
    expect(find.byKey(const Key('watchlistListTile')), findsOneWidget);
  }

  Future<void> clickMovieListTile() async {
    final movieListTileFinder = find.byKey(const Key('movieListTile'));
    await tester.ensureVisible(movieListTileFinder);
    await tester.tap(movieListTileFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickTvListTile() async {
    final tvListTileFinder = find.byKey(const Key('tvListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(HomeTvPage), findsOneWidget);
  }

  Future<void> clickWatchlistListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('watchlistMovieListTile')), findsOneWidget);
    expect(find.byKey(const Key('watchlistTvListTile')), findsOneWidget);
  }

  Future<void> clickWatchlistMovieListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistMovieListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(WatchlistMoviesPage), findsOneWidget);
  }

  Future<void> clickWatchlistTvListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistTvListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeMoviePage), findsNothing);
    expect(find.byType(WatchlistTvPage), findsOneWidget);
  }
}
