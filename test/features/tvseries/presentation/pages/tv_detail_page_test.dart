import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/tv.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/tv_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/tv_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_page_test.mocks.dart';

@GenerateMocks([TvDetailNotifier])
void main() {
  late MockTvDetailNotifier mockNotifier;

  setUp(() {
    mockNotifier = MockTvDetailNotifier();
  });

  Widget makeTestableWidget(Widget body) {
    return ChangeNotifierProvider<TvDetailNotifier>.value(
      value: mockNotifier,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  const tId = 1;

  group('Page Tv Detail', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loading);

      final progressBarFinder = find.byType(CircularProgressIndicator);
      final centerFinder = find.byType(Center);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(centerFinder, findsOneWidget);
      expect(progressBarFinder, findsOneWidget);
    });

    testWidgets('should display detail content when data is loaded',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.loaded);
      when(mockNotifier.recommendationState).thenReturn(RequestState.loaded);
      when(mockNotifier.tvDetail).thenReturn(testTvDetail);
      when(mockNotifier.tvRecommendations).thenReturn(<Tv>[]);

      final contentDetailFinder = find.byKey(const Key('content_detail'));
      final listViewRecomendationsFinder = find.byKey(const Key(
        'content_detail_recommendation',
      ));

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(contentDetailFinder, findsOneWidget);
      expect(listViewRecomendationsFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(mockNotifier.tvState).thenReturn(RequestState.error);
      when(mockNotifier.recommendationState).thenReturn(RequestState.error);
      when(mockNotifier.message).thenReturn('Error message');

      final textFinder = find.byKey(const Key('error_message'));
      final textFinder2 = find.byType(Text);

      await tester.pumpWidget(makeTestableWidget(const TvDetailPage(
        id: tId,
      )));

      expect(textFinder, findsOneWidget);
      expect(textFinder2, findsOneWidget);
    });
  });
}
