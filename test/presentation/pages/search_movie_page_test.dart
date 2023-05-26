import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/domain/entities/movie.dart';
import 'package:app_ditonton/presentation/pages/search_movie_page.dart';
import 'package:app_ditonton/presentation/provider/movie_search_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_movie_page_test.mocks.dart';

@GenerateMocks([MovieSearchNotifier])
void main() {
  late MockMovieSearchNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockMovieSearchNotifier();
  });

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
