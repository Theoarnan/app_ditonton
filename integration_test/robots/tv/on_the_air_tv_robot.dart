import 'dart:io';

import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/on_the_air_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/widgets/tv_card_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class OnTheAirTvRobot {
  final WidgetTester tester;
  OnTheAirTvRobot(this.tester);

  Future<void> scrollOnTheAirTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('listOnTheAirTv'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byType(TvCard), findsWidgets);
      expect(find.byKey(const Key('listOnTheAirTv0')), findsOneWidget);
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
    expect(find.byType(OnTheAirTvPage), findsNothing);
  }
}
