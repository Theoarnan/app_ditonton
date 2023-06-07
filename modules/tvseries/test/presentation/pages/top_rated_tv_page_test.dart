import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late MockTopRatedTvNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTopRatedTvNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TopRatedTvNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page Top Rated Tv', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display list top rated content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.loaded);
      when(mockNotifier.tv).thenReturn(tTvList);

      final listViewFinder = find.byType(ListView);

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(listViewFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.state).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const TopRatedTvPage()));

      expect(textFinder, findsOneWidget);
    });
  });
}
