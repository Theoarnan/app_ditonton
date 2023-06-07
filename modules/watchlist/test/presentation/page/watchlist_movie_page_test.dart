import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:watchlist/presentation/pages/watchlist_movies_page.dart';
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

  final testMovieList = [testMovie];

  group('Page Watchlist Movie', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'should display list watchlist movie content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn(testMovieList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty content  watchlist movie when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.loaded);
      when(mockNotifier.watchlistMovies).thenReturn([]);

      final emptyContent = find.byKey(const Key('emptyDataWatchlistMovie'));
      final emptyContentText = find.text('Empty data watchlist movie');

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.watchlistState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message_watchlist_movie'));

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
