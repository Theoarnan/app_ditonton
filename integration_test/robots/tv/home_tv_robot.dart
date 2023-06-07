import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:search/search.dart';
import 'package:tvseries/tvseries.dart';

class HomeTvRobot {
  final WidgetTester tester;
  HomeTvRobot(this.tester);

  Future<void> scrollTvPage({bool scrollUp = false}) async {
    final scrollViewFinder = find.byKey(const Key('tvScrollView'));
    if (scrollUp) {
      await tester.fling(scrollViewFinder, const Offset(0, 2000), 10000);
      await tester.pumpAndSettle();
    } else {
      await tester.fling(scrollViewFinder, const Offset(0, -2000), 10000);
      await tester.pumpAndSettle();
    }

    /// expected
    expect(find.text('On The Air'), findsOneWidget);
    expect(find.text('Popular'), findsOneWidget);
    expect(find.text('Top Rated'), findsOneWidget);
    expect(find.byKey(const Key('listview_on_the_air')), findsOneWidget);
    expect(find.byKey(const Key('listview_popular')), findsOneWidget);
    expect(find.byKey(const Key('listview_top_rated')), findsOneWidget);
  }

  Future<void> clickSeeOnTheAirTv() async {
    final seeOnTheAirTvButtonFinder = find.byKey(
      const Key('seeMoreOnTheAirTv'),
    );
    await tester.ensureVisible(seeOnTheAirTvButtonFinder);
    await tester.tap(seeOnTheAirTvButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeTvPage), findsNothing);
    expect(find.byType(OnTheAirTvPage), findsOneWidget);
    expect(find.text('On The Air TV'), findsOneWidget);
    expect(find.byKey(const Key('listOnTheAirTv')), findsOneWidget);
  }

  Future<void> clickSeeMorePopularTv() async {
    final seePopularTvButtonFinder = find.byKey(const Key('seeMorePopularTv'));
    await tester.ensureVisible(seePopularTvButtonFinder);
    await tester.tap(seePopularTvButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeTvPage), findsNothing);
    expect(find.byType(PopularTvPage), findsOneWidget);
    expect(find.text('Popular TV'), findsOneWidget);
    expect(find.byKey(const Key('listPopularTv')), findsOneWidget);
  }

  Future<void> clickSeeMoreTopRatedTv() async {
    final seeTopRatedTvButtonFinder =
        find.byKey(const Key('seeMoreTopRatedTv'));
    await tester.ensureVisible(seeTopRatedTvButtonFinder);
    await tester.tap(seeTopRatedTvButtonFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeTvPage), findsNothing);
    expect(find.byType(TopRatedTvPage), findsOneWidget);
    expect(find.text('Top Rated TV'), findsOneWidget);
    expect(find.byKey(const Key('listTopRatedTv')), findsOneWidget);
  }

  Future<void> clickTvItem({required String keyList}) async {
    final tvItemFinder = find.byKey(Key(keyList));
    await tester.ensureVisible(tvItemFinder);
    await tester.tap(tvItemFinder);
    await tester.pumpAndSettle();
  }

  Future<void> clickSearchTvButton() async {
    final searchButtonTvFinder = find.byKey(const Key('searchButtonTv'));
    await tester.ensureVisible(searchButtonTvFinder);
    await tester.tap(searchButtonTvFinder);
    await tester.pumpAndSettle();

    /// expected
    expect(find.byType(HomeTvPage), findsNothing);
    expect(find.byType(SearchTvPage), findsOneWidget);
    expect(find.text('Search TV'), findsOneWidget);
    expect(find.byKey(const Key('enterSearchQueryTv')), findsOneWidget);
    expect(find.byKey(const Key('list_search_tv')), findsNothing);
    expect(find.byKey(const Key('emptyDataSearchTv')), findsOneWidget);
    expect(find.text('Search tv'), findsOneWidget);
  }
}
