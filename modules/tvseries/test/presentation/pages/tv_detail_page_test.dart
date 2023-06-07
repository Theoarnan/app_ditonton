import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/navigiation.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late MockTvDetailNotifier mockNotifier;
  late MockRouteObserver mockObserver;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
    mockObserver = MockRouteObserver();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
        navigatorObservers: [mockObserver],
      ),
    );
  }

  const tId = 1;

  const seasonsTemp = <Season>[
    Season(
      airDate: "2023-01-23",
      episodeCount: 73,
      id: 294181,
      name: "Season 1",
      overview: "",
      posterPath: '',
      seasonNumber: 1,
    )
  ];

  const testTvDetailTemp = TvDetail(
    adult: false,
    backdropPath: '/mAJ84W6I8I272Da87qplS2Dp9ST.jpg',
    firstAirDate: '2023-01-23',
    genres: [Genre(id: 9648, name: 'Mystery')],
    id: 202250,
    name: 'Dirty Linen',
    numberOfEpisodes: 93,
    numberOfSeasons: 2,
    originalName: "Dirty Linen",
    overview:
        "To exact vengeance, a young woman infiltrates the household of an influential family as a housemaid to expose their dirty secrets. However, love will get in the way of her revenge plot.",
    popularity: 2901.537,
    posterPath: "",
    voteAverage: 4.941,
    voteCount: 17,
    seasons: seasonsTemp,
  );

  group('Page Tv Detail', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display detail content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.tvRecommendations).thenReturn(tTvList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final contentDetailFinder = find.byKey(const Key('content_detail_tv'));
      final listViewRecomendationsFinder = find.byKey(const Key(
        'content_detail_recommendation',
      ));

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(contentDetailFinder, findsOneWidget);
      expect(listViewRecomendationsFinder, findsOneWidget);
    });

    testWidgets('should season display image empty when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetailTemp);
      when(mockNotifier.tvRecommendations).thenReturn(tTvList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final imgEmptyLoadingFinder =
          find.byKey(const Key('loading_image_empty'));

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(imgEmptyLoadingFinder, findsOneWidget);
    });

    testWidgets('should display text with message when error detail',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.error);
      when(mockNotifier.recommendationState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should display text with message when error recomendation',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.recommendationState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder2 = find.byKey(const Key('error_message_recomendation'));

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(textFinder2, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display add icon when movie not added to watchlist',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      final watchlistButtonIcon = find.byIcon(Icons.add);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should dispay check icon when movie is added to wathclist',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);

      final watchlistButtonIcon = find.byIcon(Icons.check);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

      expect(watchlistButtonIcon, findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when added to watchlist',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Added to Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display Snackbar when remove from watchlist',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(true);
      when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.check), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(SnackBar), findsOneWidget);
      expect(find.text('Removed from Watchlist'), findsOneWidget);
    });

    testWidgets(
        'Watchlist button should display AlertDialog when add to watchlist failed',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);
      when(mockNotifier.watchlistMessage).thenReturn('Failed');

      final watchlistButton = find.byType(ElevatedButton);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));

      expect(find.byIcon(Icons.add), findsOneWidget);

      await tester.tap(watchlistButton);
      await tester.pump();

      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
    });

    testWidgets('should back from detail page to home page',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.tvRecommendations).thenReturn(tTvList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
      expect(find.byKey(const Key('buttonBackDetailTv')), findsOneWidget);

      await tester.tap(find.byKey(const Key('buttonBackDetailTv')));
      await tester.pumpAndSettle();
    });

    testWidgets('should container if no state recomendation',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendationState).thenReturn(RequestState.empty);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.tvRecommendations).thenReturn(tTvList);
      when(mockNotifier.isAddedToWatchlist).thenReturn(false);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(id: 1)));
      expect(find.byKey(const Key('empty_widget_tv')), findsOneWidget);
    });
  });
}
