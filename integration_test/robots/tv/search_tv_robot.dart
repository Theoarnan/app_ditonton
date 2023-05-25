import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class SearchTvRobot {
  final WidgetTester tester;
  SearchTvRobot(this.tester);

  Future<void> enterSearchQuery(String query) async {
    final textFieldFinder = find.byKey(const Key('enterSearchQueryTv'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);

    await tester.pumpAndSettle();
  }

  Future<void> scrollSearchTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvSearchScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 600), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -600), 10000);
      await tester.pumpAndSettle();
    }
  }

  Future<void> goBack() async {
    await tester.pageBack();
    await tester.pumpAndSettle();
    sleep(const Duration(seconds: 2));
  }
}
