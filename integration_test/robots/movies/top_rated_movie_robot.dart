import 'dart:io';

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
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
