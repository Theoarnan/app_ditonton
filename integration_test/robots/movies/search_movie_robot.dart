import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:movies/movies.dart';
import 'package:search/search.dart';

class SearchMovieRobot {
  final WidgetTester tester;
  SearchMovieRobot(this.tester);

  Future<void> enterSearchQuery(String query) async {
    final textFieldFinder = find.byKey(const Key('enterSearchQueryMovie'));

    await tester.ensureVisible(textFieldFinder);
    await tester.enterText(textFieldFinder, query);
    await tester.testTextInput.receiveAction(TextInputAction.done);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byKey(const Key('list_search_movie')), findsOneWidget);
    expect(find.byKey(const Key('movieSearchScrollView')), findsOneWidget);
    expect(find.byKey(const Key('listMovieSearch0')), findsOneWidget);
  }

  Future<void> scrollSearchMoviePage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('movieSearchScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 1000), 10000);
      await tester.pumpAndSettle();

      /// expected
      expect(find.byKey(const Key('listMovieSearch0')), findsOneWidget);
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
    expect(find.byType(HomeMoviePage), findsOneWidget);
    expect(find.byType(SearchMoviePage), findsNothing);
  }
}
