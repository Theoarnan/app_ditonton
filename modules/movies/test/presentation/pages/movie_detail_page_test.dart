import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.mocks.dart';

void main() {
  late MockMovieDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  testWidgets('should display detail content when data is loaded',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.movieRecommendations).thenReturn(tMovieList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final contentDetailFinder = find.byKey(const Key('content_detail_movie'));
    final listViewRecomendationsFinder1 = find.byKey(const Key(
      'content_movie_detail_recommendation',
    ));
    final listViewRecomendationsFinder2 = find.byKey(const Key(
      'list_builder_recomendation',
    ));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(contentDetailFinder, findsOneWidget);
    expect(listViewRecomendationsFinder1, findsOneWidget);
    expect(listViewRecomendationsFinder2, findsOneWidget);
  });

  testWidgets('should display text with message when Error Detail Page Movie',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.error);
    when(mockNotifier.recommendationState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final textFinder1 = find.byKey(const Key('error_message_detail_movie'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(textFinder1, findsOneWidget);
  });

  testWidgets(
      'should display text with message when Error get recomendationn Detail Page Movie',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.recommendationState).thenReturn(RequestState.error);
    when(mockNotifier.message).thenReturn('Error message');

    final textFinder1 = find.byKey(const Key('error_message_2'));

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(
      id: 1,
    )));

    expect(textFinder1, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display add icon when movie not added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    final watchlistButtonIcon = find.byIcon(Icons.add);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should dispay check icon when movie is added to wathclist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);

    final watchlistButtonIcon = find.byIcon(Icons.check);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(watchlistButtonIcon, findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when added to watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Added to Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Added to Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display Snackbar when removed from watchlist',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(true);
    when(mockNotifier.watchlistMessage).thenReturn('Removed from Watchlist');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.check), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(SnackBar), findsOneWidget);
    expect(find.text('Removed from Watchlist'), findsOneWidget);
  });

  testWidgets(
      'Watchlist button should display AlertDialog when add to watchlist failed',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movieRecommendations).thenReturn(<Movie>[]);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);
    when(mockNotifier.watchlistMessage).thenReturn('Failed');

    final watchlistButton = find.byType(ElevatedButton);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));

    expect(find.byIcon(Icons.add), findsOneWidget);

    await tester.tap(watchlistButton);
    await tester.pump();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Failed'), findsOneWidget);
  });

  testWidgets('should back from detail page to home page',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.movieRecommendations).thenReturn(tMovieList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(find.byKey(const Key('buttonBackDetailMovie')), findsOneWidget);

    await tester.tap(find.byKey(const Key('buttonBackDetailMovie')));
    await tester.pumpAndSettle();
  });

  testWidgets('should container if no state recomendation',
      (WidgetTester tester) async {
    when(mockNotifier.movieState).thenReturn(RequestState.loaded);
    when(mockNotifier.recommendationState).thenReturn(RequestState.empty);
    when(mockNotifier.movie).thenReturn(testMovieDetail);
    when(mockNotifier.movieRecommendations).thenReturn(tMovieList);
    when(mockNotifier.isAddedToWatchlist).thenReturn(false);

    await tester.pumpWidget(makeTestableWidget(const MovieDetailPage(id: 1)));
    expect(find.byKey(const Key('empty_widget')), findsOneWidget);
  });
}
