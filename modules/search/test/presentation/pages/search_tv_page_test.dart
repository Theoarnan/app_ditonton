import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:search/search.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_search.dart';

void main() {
  late SearchBloc searchBloc;

  setUpAll(() {
    searchBloc = MockSearchBloc();
    registerFallbackValue(FakeSearchEvent());
    registerFallbackValue(FakeSearchState());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: BlocProvider<SearchBloc>.value(
        value: searchBloc,
        child: body,
      ),
    );
  }

  group('Page search tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());

      final centerFinder = find.byKey(const Key('loading_search_tv'));
      final progressBarFinder = find.byKey(const Key('circular_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list search content when data is loaded',
        (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());
      when(() => searchBloc.state).thenReturn(SearchTvHasData(tTvList));

      final listViewFinder = find.byKey(const Key('list_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is loaded but empty',
        (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());
      when(() => searchBloc.state).thenReturn(SearchEmpty());

      final emptyContent = find.byKey(const Key('emptyDataSearchTv'));
      final emptyContentText = find.text('Search tv not found');

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets(
        'should display empty content in list search when data is empty',
        (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());
      when(() => searchBloc.state).thenReturn(InitSearch());

      final emptyContent = find.byKey(const Key('emptyDataSearchTv'));
      final emptyContentText = find.text('Search tv');

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(emptyContent, findsOneWidget);
      expect(emptyContentText, findsOneWidget);
    });

    testWidgets('should display text with message when error',
        (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());
      when(() => searchBloc.state).thenReturn(
        const SearchError('Error message'),
      );

      final textFinder = find.byKey(const Key('error_message_search_tv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));

      expect(textFinder, findsOneWidget);
    });

    testWidgets('should text field is submit', (WidgetTester tester) async {
      when(() => searchBloc.state).thenReturn(SearchLoading());
      when(() => searchBloc.state).thenReturn(SearchTvHasData(tTvList));

      final textFieldFinder = find.byKey(const Key('enterSearchQueryTv'));

      await tester.pumpWidget(makeTestableWidget(const SearchTvPage()));
      await tester.ensureVisible(textFieldFinder);
      await tester.enterText(textFieldFinder, 'Dirty');
      await tester.testTextInput.receiveAction(TextInputAction.search);
      await tester.pump();

      expect(find.byKey(const Key('list_search_tv')), findsOneWidget);
      expect(find.byKey(const Key('tvSearchScrollView')), findsOneWidget);
      expect(find.byKey(const Key('listTvSearch0')), findsOneWidget);
    });
  });
}
