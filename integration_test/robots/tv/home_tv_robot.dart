import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeTvRobot {
  final WidgetTester tester;
  HomeTvRobot(this.tester);

  Future<void> scrollTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -1000), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> clickSeeMorePopularTv() async {
    final seePopularTvButtonFinder = find.byKey(const Key('seeMorePopularTv'));
    await tester.ensureVisible(seePopularTvButtonFinder);
    await tester.tap(seePopularTvButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickSeeMoreTopRatedTv() async {
    final seeTopRatedTvButtonFinder =
        find.byKey(const Key('seeMoreTopRatedTv'));
    await tester.ensureVisible(seeTopRatedTvButtonFinder);
    await tester.tap(seeTopRatedTvButtonFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickTvItem({required String keyList}) async {
    final tvItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(tvItemFinder);
    await tester.tap(tvItemFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickSearchTvButton() async {
    final searchButtonTvFinder = find.byKey(const Key('searchButtonTv'));
    await tester.ensureVisible(searchButtonTvFinder);
    await tester.tap(searchButtonTvFinder);
    await tester.pumpAndSettle();
  }
}
