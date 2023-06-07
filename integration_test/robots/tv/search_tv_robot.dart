import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class SearchTvRobot {
  final WidgetTester tester;
  SearchTvRobot(this.tester);

  Future<void> enterSearchQuery(String query) async {
    final textFieldFinder = find.byKey(const Key('enterSearchQueryTv'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('list_search_tv')), findsOneWidget);
    expect(find.byKey(const Key('tvSearchScrollView')), findsOneWidget);
    expect(find.byKey(const Key('listTvSearch0')), findsOneWidget);
  }

  Future<void> scrollSearchTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvSearchScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byKey(const Key('listTvSearch0')), findsOneWidget);
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
    expect(find.byType(SearchTvPage), findsNothing);
  }
}
