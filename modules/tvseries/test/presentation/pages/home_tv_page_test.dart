import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late MockTvListNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvListNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvListNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page home tv', () {
    testWidgets('should display center progress bar when loading', (
      WidgetTester tester,
    ) async {
      when(mockNotifier.onTheAirState).thenReturn(RequestState.loading);
      when(mockNotifier.popularTvState).thenReturn(RequestState.loading);
      when(mockNotifier.topRatedTvState).thenReturn(RequestState.loading);

      final centerOnTheAirFinder = find.byKey(const Key('loading_on_the_air'));
      final progressBarOnTheAirFinder =
          find.byKey(const Key('circular_on_the_air'));

      final centerPopularFinder = find.byKey(const Key('loading_popular'));
      final progressBarPopularFinder =
          find.byKey(const Key('circular_popular'));

      final centerTopRatedFinder = find.byKey(const Key('loading_top_rated'));
      final progressBarTopRatedFinder =
          find.byKey(const Key('circular_top_rated'));

      await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

      expect(centerOnTheAirFinder, findsOneWidget);
      expect(progressBarOnTheAirFinder, findsOneWidget);

      expect(centerPopularFinder, findsOneWidget);
      expect(progressBarPopularFinder, findsOneWidget);

      expect(centerTopRatedFinder, findsOneWidget);
      expect(progressBarTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display detail content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.onTheAirState).thenReturn(RequestState.loaded);
      when(mockNotifier.popularTvState).thenReturn(RequestState.loaded);
      when(mockNotifier.topRatedTvState).thenReturn(RequestState.loaded);

      when(mockNotifier.onTheAirTv).thenReturn(tTvList);
      when(mockNotifier.popularTv).thenReturn(tTvList);
      when(mockNotifier.topRatedTv).thenReturn(tTvList);

      final listViewOnTheAirFinder = find.byKey(
        const Key('listview_on_the_air'),
      );
      final listViewPopularFinder = find.byKey(
        const Key('listview_popular'),
      );
      final listViewTopRatedFinder = find.byKey(
        const Key('listview_top_rated'),
      );

      await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

      expect(listViewOnTheAirFinder, findsOneWidget);
      expect(listViewPopularFinder, findsOneWidget);
      expect(listViewTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.onTheAirState).thenReturn(RequestState.error);
      when(mockNotifier.popularTvState).thenReturn(RequestState.error);
      when(mockNotifier.topRatedTvState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textOnTheAirFinder = find.byKey(
        const Key('error_message_on_the_air'),
      );
      final textPopularFinder = find.byKey(
        const Key('error_message_popular'),
      );
      final textTopRatedFinder = find.byKey(
        const Key('error_message_top_rated'),
      );

      await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

      expect(textOnTheAirFinder, findsOneWidget);
      expect(textPopularFinder, findsOneWidget);
      expect(textTopRatedFinder, findsOneWidget);
    });
  });
}
