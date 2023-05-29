import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/search_tv_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'search_tv_page_test.mocks.dart';

@GenerateMocks([TvSearchNotifier])
void main() {
  late MockTvSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvSearchNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final tTv = Tv(
    id: 202250,
    name: 'Dirty Linen',
    backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
    firstAirDate: '2023-01-23',
    genreIds: const [9648, 18],
    originalName: 'Dirty Linen',
    overview:
        'To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.',
    popularity: 2901.537,
    posterPath: '/aoAZgnmMzY9vVy9VWnO3U5PZENh.jpg',
    voteAverage: 4.9,
    voteCount: 17,
  );
  final listTv = <Tv>[tTv];

  group('Page search tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loading);

      final centerFinder = find.byKey(const Key('loading_search_tv'));
      final progressBarFinder = find.byKey(const Key('circular_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list search content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(listTv);

      final listViewFinder = find.byKey(const Key('list_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(<Tv>[]);

      final emptyContent = find.byKey(const Key('emptyDataSearchTv'));
      final emptyContentText = find.text('Search tv not found');

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.empty);
      when(mockNotifier.searchResult).thenReturn(<Tv>[]);

      final emptyContent = find.byKey(const Key('emptyDataSearchTv'));
      final emptyContentText = find.text('Search tv');

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should text field is submit', (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(listTv);

      final textFieldFinder = find.byKey(const Key('enterSearchQueryTv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
      await tester.ensureVisible(textFieldFinder);
      await tester.enterText(textFieldFinder, 'Dirty');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });
  });
}
