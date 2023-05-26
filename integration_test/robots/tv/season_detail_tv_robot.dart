import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SeasonDetailTvRobot {
  final WidgetTester tester;
  SeasonDetailTvRobot(this.tester);

  Future<void> scrollSeasonEpisodeDetailTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listSeasonEpisodeTv'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    final backButtonFinder = find.byKey(const Key('buttonBackSeasonDetailTv'));
    await tester.ensureVisible(backButtonFinder);
    await tester.tap(backButtonFinder);
    await tester.pumpAndSettle();
  }
}
