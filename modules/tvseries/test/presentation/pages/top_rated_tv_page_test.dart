import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvTopRatedBloc tvTopRatedBloc;

  setUpAll(() {
    tvTopRatedBloc = MockTvTopRatedBloc();
    registerFallbackValue(MockTvTopRatedState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvTopRatedBloc>.value(
      value: tvTopRatedBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page top rated tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list top rated content when data is loaded',
        (WidgetTester tester) async {
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedHasData(tTvList));

      final listViewFinder = find.byType(ListView);
      final listViewKeyFinder = find.byKey(const Key('listTopRatedTv'));
      final listViewContentFinder = find.byKey(const Key('listTopRatedTv0'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
      expect(listViewKeyFinder, findsOneWidget);
      expect(listViewContentFinder, findsOneWidget);
    });

    testWidgets('should display ilustration empty when state is empty',
        (WidgetTester tester) async {
      when(() => tvTopRatedBloc.state).thenReturn(TvTopRatedEmpty());

      final ilustrationFinder = find.byKey(const Key('emptyDataTopRatedTv'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(ilustrationFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      const empty = 'Error message';
      when(() => tvTopRatedBloc.state).thenReturn(const TvTopRatedError(empty));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
