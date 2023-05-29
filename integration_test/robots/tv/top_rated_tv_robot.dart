import 'dart:io';

import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/top_rated_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/widgets/tv_card_list.dart';
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

      /// expected
      expect(find.byType(TvCard), findsWidgets);
      expect(find.byKey(const Key('listTopRatedTv0')), findsOneWidget);
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
    expect(find.byType(HomeTvPage), findsOneWidget);
    expect(find.byType(TopRatedTvPage), findsNothing);
  }
}
