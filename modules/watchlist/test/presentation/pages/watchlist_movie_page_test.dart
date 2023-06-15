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

  final testMovieList = [testMovie];

  group('Page Watchlist Movie', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets(
        'should display list watchlist movie content when data is loaded',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(
        WatchlistMovieHasData(testMovieList),
      );

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty content  watchlist movie when data is loaded',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(WatchlistEmpty());

      final emptyContent = find.byKey(const Key('emptyDataWatchlistMovie'));
      final emptyContentText = find.text('Empty data watchlist movie');

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(
        const WatchlistError('Error message'),
      );

      final textFinder = find.byKey(const Key('error_message_watchlist_movie'));

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display nothing when state init',
        (WidgetTester tester) async {
      when(() => watchlistBloc.state).thenReturn(WatchlistLoading());
      when(() => watchlistBloc.state).thenReturn(InitWatchlist());

      final textFinder = find.byType(SizedBox);

      await tester.pumpWidget(makeTestableWidget(const WatchlistMoviesPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
