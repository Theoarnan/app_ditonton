import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/presentation/pages/watchlist_tv_page.dart';
import 'package:watchlist/presentation/provider/watchlist_notifier.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_watchlist.mocks.dart';

void main() {
  late MockWatchlistNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockWatchlistNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<WatchlistNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testTvList = [testTv];

  group('Page Watchlist Tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list watchlist tv content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTv).thenReturn(testTvList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('should display empty content watchlist tv when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistTv).thenReturn([]);

      final emptyContent = find.byKey(const Key('emptyDataWatchlistTv'));
      final emptyContentText = find.text('Empty data watchlist tv');

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder =
          find.byKey(const Key('error_message_watchlist_movie_tv'));

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
