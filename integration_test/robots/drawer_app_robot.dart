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
  }

  Future<void> clickNavigationDrawerButtonTv() async {
    final drawerButtonFinder = find.byKey(const Key('drawerButtonTv'));
    await tester.ensureVisible(drawerButtonFinder);
    await tester.tap(drawerButtonFinder);
    await tester.pumpAndSettle();
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
  }

  Future<void> clickWatchlistListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickWatchlistMovieListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistMovieListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickWatchlistTvListTile() async {
    final tvListTileFinder = find.byKey(const Key('watchlistTvListTile'));
    await tester.ensureVisible(tvListTileFinder);
    await tester.tap(tvListTileFinder);
    await tester.pumpAndSettle();
  }
}
