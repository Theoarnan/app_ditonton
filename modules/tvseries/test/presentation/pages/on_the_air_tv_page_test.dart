import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvOnTheAirBloc tvOnTheAirBloc;

  setUpAll(() {
    tvOnTheAirBloc = MockTvOnTheAirBloc();
    registerFallbackValue(MockTvOnTheAirState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvOnTheAirBloc>.value(
      value: tvOnTheAirBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page ontheair tvseries', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirLoading());

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list on the air content when data is loaded',
        (WidgetTester tester) async {
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirHasData(tTvList));

      final listViewFinder = find.byType(ListView);
      final listViewKeyFinder = find.byKey(const Key('listOnTheAirTv'));
      final listViewContentFinder = find.byKey(const Key('listOnTheAirTv0'));

      await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

      expect(listViewFinder, findsOneWidget);
      expect(listViewKeyFinder, findsOneWidget);
      expect(listViewContentFinder, findsOneWidget);
    });

    testWidgets('should display ilustration empty when state is empty',
        (WidgetTester tester) async {
      when(() => tvOnTheAirBloc.state).thenReturn(TvOnTheAirEmpty());

      final ilustrationFinder = find.byKey(const Key('emptyDataOnTheAirTv'));

      await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

      expect(ilustrationFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      const empty = 'Error message';
      when(() => tvOnTheAirBloc.state).thenReturn(const TvOnTheAirError(empty));

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const OnTheAirTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
