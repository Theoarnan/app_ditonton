import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/movies.dart';
import 'package:provider/provider.dart';
import 'package:search/presentation/pages/search_movie_page.dart';
import 'package:search/presentation/provider/movie_search_notifier.dart';

import '../../test_helper/test_helper_search.mocks.dart';

void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

  final testMovie = Movie(
    adult: false,
    backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
    genreIds: const [14, 28],
    id: 557,
    originalTitle: 'Spider-Man',
    overview:
        'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
    popularity: 60.441,
    posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
    releaseDate: '2002-05-01',
    title: 'Spider-Man',
    video: false,
    voteAverage: 7.2,
    voteCount: 13507,
  );

  final testMovieList = [testMovie];

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<MovieSearchNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page search movie', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loading);

      final centerFinder = find.byKey(const Key('loading_search_movie'));
      final progressBarFinder = find.byKey(const Key('circular_search_movie'));

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list search content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(testMovieList);

      final listViewFinder = find.byKey(const Key('list_search_movie'));

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(<Movie>[]);

      final emptyContent = find.byKey(const Key('emptyDataSearchMovie'));
      final emptyContentText = find.text('Search movie not found');

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is empty',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.empty);
      when(mockNotifier.searchResult).thenReturn(<Movie>[]);

      final emptyContent = find.byKey(const Key('emptyDataSearchMovie'));
      final emptyContentText = find.text('Search movie');

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message_search_movie'));

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should text field is submit', (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.searchResult).thenReturn(<Movie>[]);

      final textFieldFinder = find.byKey(const Key('enterSearchQueryMovie'));

      await tester.pumpWidget(makeTestableWidget(const SearchMoviePage()));
      await tester.ensureVisible(textFieldFinder);
      await tester.enterText(textFieldFinder, 'Dirty');
      await tester.testTextInput.receiveAction(TextInputAction.done);
      await tester.pump();
    });
  });
}
