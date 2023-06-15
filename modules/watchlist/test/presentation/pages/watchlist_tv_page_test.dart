import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:watchlist/watchlist.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_watchlist.dart';

void main() {
  late WatchlistBloc watchlistBloc;

  setUpAll(() {
    watchlistBloc = MockWatchlistBloc();
    registerFallbackValue(FakeWatchlistEvent());
    registerFallbackValue(FakeWatchlistState());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<WatchlistBloc>.value(
        value: watchlistBloc,
        child: body,
      ),
    );
  }

  final testTvList = [testTv];

  group('Page Watchlist Tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list watchlist tv content when data is loaded',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(
        WatchlistTvHasData(testTvList),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('should display empty content watchlist tv when data is loaded',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(WatchlistEmpty());

      final emptyContent = find.byKey(const Key('emptyDataWatchlistTv'));
      final emptyContentText = find.text('Empty data watchlist tv');

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(
        const WatchlistError('Error message'),
      );

      final textFinder = find.byKey(
        const Key('error_message_watchlist_movie_tv'),
      );

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display nothing when state init',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(InitWatchlist());

      final textFinder = find.byType(SizedBox);

      await tester.pumpWidget(makeTestableWidget(const WatchlistTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
