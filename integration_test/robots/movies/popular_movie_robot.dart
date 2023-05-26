import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class PopularMovieRobot {
  final WidgetTester tester;
  PopularMovieRobot(this.tester);

  Future<void> scrollPopularMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listPopularMovies'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 5000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 5000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
