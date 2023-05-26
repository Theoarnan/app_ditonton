import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class TopRatedTvRobot {
  final WidgetTester tester;
  TopRatedTvRobot(this.tester);

  Future<void> scrollTopRatedTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listTopRatedTv'));
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
