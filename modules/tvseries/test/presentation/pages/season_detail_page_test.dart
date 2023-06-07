import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.mocks.dart';

void main() {
  late MockSeasonDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockSeasonDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<SeasonDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page Season Detail', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.seasonState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display detail content season when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.seasonState).thenReturn(RequestState.loaded);
      when(mockNotifier.seasonDetail).thenReturn(testSeasonDetail);

      final contentDetailFinder = find.byKey(
        const Key('content_detail_season'),
      );
      final contentDetailDividerEpisodeFinder = find.byKey(
        const Key('divider_content_detail_season0'),
      );

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(contentDetailFinder, findsOneWidget);
      expect(contentDetailDividerEpisodeFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.seasonState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(textFinder, findsOneWidget);
    });
  });
}
