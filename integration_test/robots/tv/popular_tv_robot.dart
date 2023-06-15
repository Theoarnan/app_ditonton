import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tvseries/tvseries.dart';

class PopularTvRobot {
  final WidgetTester tester;
  PopularTvRobot(this.tester);

  Future<void> scrollPopularTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listPopularTv'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 5000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byType(TvCard), findsWidgets);
      expect(find.byKey(const Key('listPopularTv0')), findsOneWidget);
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 5000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));

    /// expected
    expect(find.byType(HomeTvPage), findsOneWidget);
    expect(find.byType(PopularTvPage), findsNothing);
  }
}
