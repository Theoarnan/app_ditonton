import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/home_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_list_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'home_tv_page_test.mocks.dart';

@GenerateMocks([TvListNotifier])
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

  const tTv = Tv(
    id: 202250,
    name: 'Dirty Linen',
    backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
    firstAirDate: '2023-01-23',
    genreIds: [9648, 18],
    originalName: 'Dirty Linen',
    overview:
        'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
    popularity: 2901.537,
    posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
    voteAverage: 4.9,
    voteCount: 17,
  );
  const listTv = <Tv>[tTv];

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

      when(mockNotifier.onTheAirTv).thenReturn(listTv);
      when(mockNotifier.popularTv).thenReturn(listTv);
      when(mockNotifier.topRatedTv).thenReturn(listTv);

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
