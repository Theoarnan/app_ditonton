import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvPopularBloc tvPopularBloc;

  setUpAll(() {
    tvPopularBloc = MockTvPopularBloc();
    registerFallbackValue(MockTvPopularState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvPopularBloc>.value(
      value: tvPopularBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page popular tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvPopularBloc.state).thenReturn(TvPopularLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list popular content when data is loaded',
        (WidgetTester tester) async {
      when(() => tvPopularBloc.state).thenReturn(TvPopularHasData(tTvList));

      final listViewFinder = find.byType(ListView);
      final listViewKeyFinder = find.byKey(const Key('listPopularTv'));
      final listViewContentFinder = find.byKey(const Key('listPopularTv0'));

      await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(listViewFinder, findsOneWidget);
      expect(listViewKeyFinder, findsOneWidget);
      expect(listViewContentFinder, findsOneWidget);
    });

    testWidgets('should display ilustration empty when state is empty',
        (WidgetTester tester) async {
      when(() => tvPopularBloc.state).thenReturn(TvPopularEmpty());

      final ilustrationFinder = find.byKey(const Key('emptyDataPopularTv'));

      await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(ilustrationFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      const empty = 'Error message';
      when(() => tvPopularBloc.state).thenReturn(const TvPopularError(empty));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const PopularTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
