import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';

class TopRatedMovieRobot {
  final WidgetTester tester;
  TopRatedMovieRobot(this.tester);

  Future<void> scrollTopRatedMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listTopRatedMovies'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byType(MovieCard), findsWidgets);
      expect(find.byKey(const Key('listTopRatedMovies0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(HomeMoviePage), findsOneWidget);
    expect(find.byType(TopRatedMoviesPage), findsNothing);
  }
}
