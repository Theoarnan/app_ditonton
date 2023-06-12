import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvOnTheAirBloc tvOnTheAirBloc;
  late TvPopularBloc tvPopularBloc;
  late TvTopRatedBloc tvTopRatedBloc;

  setUpAll(() {
    // movie on the air
    tvOnTheAirBloc = MockTvOnTheAirBloc();
    registerFallbackValue(MockTvOnTheAirState());
    // tv popular
    tvPopularBloc = MockTvPopularBloc();
    registerFallbackValue(MockTvPopularState());
    // tv top rated
    tvTopRatedBloc = MockTvTopRatedBloc();
    registerFallbackValue(MockTvTopRatedState());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => tvOnTheAirBloc,
          ),
          BlocProvider(
            create: (_) => tvPopularBloc,
          ),
          BlocProvider(
            create: (_) => tvTopRatedBloc,
          ),
        ],
        child: body,
      ),
    );
  }

  group('Page home tvseries test', () {
    testWidgets('should display center progress bar when loading', (
      WidgetTester tester,
    ) async {
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirLoading());
      when(() => tvPopularBloc.state).thenReturn(TvPopularLoading());
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedLoading());

      final centerOnTheAirFinder = find.byKey(const Key('loading_on_the_air'));
      final progressBarOnTheAirFinder = find.byKey(
        const Key('circular_on_the_air'),
      );
      final centerPopularFinder = find.byKey(const Key('loading_popular'));
      final progressBarPopularFinder = find.byKey(
        const Key('circular_popular'),
      );
      final centerTopRatedFinder = find.byKey(const Key('loading_top_rated'));
      final progressBarTopRatedFinder = find.byKey(
        const Key('circular_top_rated'),
      );

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
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirHasData(tTvList));
      when(() => tvPopularBloc.state).thenReturn(TvPopularHasData(tTvList));
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedHasData(tTvList));

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

    testWidgets('should display text empty when state is empty',
        (WidgetTester tester) async {
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirEmpty());
      when(() => tvPopularBloc.state).thenReturn(TvPopularEmpty());
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedEmpty());

      final textEmptyKeyOnTheAirFinder = find.byKey(
        const Key('empty_text_ontheair'),
      );
      final textEmptyOnTheAirFinder = find.text(
        '*Oops, data tv on the air is empty.',
      );
      final textEmptyKeyPopularFinder = find.byKey(
        const Key('empty_text_popular'),
      );
      final textEmptyPopularFinder = find.text(
        '*Oops, data tv popular is empty.',
      );
      final textEmptyKeyTopRatedFinder = find.byKey(
        const Key('empty_text_toprated'),
      );
      final textEmptyTopRatedFinder = find.text(
        '*Oops, data tv top rated is empty.',
      );

      await tester.pumpWidget(makeTestableWidget(const HomeTvPage()));

      expect(textEmptyKeyOnTheAirFinder, findsOneWidget);
      expect(textEmptyOnTheAirFinder, findsOneWidget);
      expect(textEmptyKeyPopularFinder, findsOneWidget);
      expect(textEmptyPopularFinder, findsOneWidget);
      expect(textEmptyKeyTopRatedFinder, findsOneWidget);
      expect(textEmptyTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      const empty = 'Error message';
      when(() => tvOnTheAirBloc.state).thenReturn(const TvOnTheAirError(empty));
      when(() => tvPopularBloc.state).thenReturn(const TvPopularError(empty));
      when(() => tvTopRatedBloc.state).thenReturn(const TvTopRatedError(empty));

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
