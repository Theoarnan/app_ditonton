import 'dart:io';

import 'package:app_ditonton/presentation/pages/home_movie_page.dart';
import 'package:app_ditonton/presentation/pages/top_rated_movies_page.dart';
import 'package:app_ditonton/presentation/widgets/movie_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

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
