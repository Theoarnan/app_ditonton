import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:tvseries/tvseries.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_tvseries.dart';

void main() {
  late TvSeasonDetailBloc tvSeasonDetailBloc;

  setUpAll(() {
    tvSeasonDetailBloc = MockTvSeasonDetailBloc();
    registerFallbackValue(MockTvSeasonDetailState());
  });

  Widget makeTestableWidget(Widget body) {
    return BlocProvider<TvSeasonDetailBloc>.value(
      value: tvSeasonDetailBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  group('Page Season Detail', () {
    testWidgets('should display center progress bar when loading',
        (WidgetTester tester) async {
      when(() => tvSeasonDetailBloc.state).thenReturn(TvSeasonDetailLoading());

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
      when(() => tvSeasonDetailBloc.state).thenReturn(
        const TvSeasonDetailHasData(testSeasonDetail),
      );

      final contentDetailFinder = find.byKey(
        const Key('content_detail_season'),
      );
      final contentDetailDividerEpisodeFinder = find.byKey(
        const Key('divider_content_detail_season0'),
      );
      final contentListEpisodeFinder = find.byKey(
        const Key('listSeasonEpisodeTv'),
      );
      final contentDataListEpisodeFinder = find.byKey(
        const Key('listSeasonEpisodeTv0'),
      );

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(contentDetailFinder, findsOneWidget);
      expect(contentDetailDividerEpisodeFinder, findsOneWidget);
      expect(contentListEpisodeFinder, findsOneWidget);
      expect(contentDataListEpisodeFinder, findsOneWidget);
    });

    testWidgets(
        'should display empty text when detail season load but episode is empty',
        (WidgetTester tester) async {
      when(() => tvSeasonDetailBloc.state).thenReturn(
        const TvSeasonDetailHasData(testSeasonDetailEmptyEpisode),
      );

      final contentDetailFinder = find.byKey(
        const Key('content_detail_season'),
      );
      final contentEmptyFinder = find.byKey(
        const Key('empty_text_episode'),
      );
      final contentTextEmptyEpisodeFinder = find.text(
        '*Oops, data episode for this season is empty.',
      );

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(contentDetailFinder, findsOneWidget);
      expect(contentEmptyFinder, findsOneWidget);
      expect(contentTextEmptyEpisodeFinder, findsOneWidget);
    });

    testWidgets('should display ilustration empty when state is empty',
        (WidgetTester tester) async {
      when(() => tvSeasonDetailBloc.state).thenReturn(TvSeasonDetailEmpty());

      final ilustrationFinder = find.byKey(
        const Key('emptyDataSeasonDetailTv'),
      );

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(ilustrationFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      const empty = 'Error message';
      when(() => tvSeasonDetailBloc.state).thenReturn(
        const TvSeasonDetailError(empty),
      );

      final textFinder = find.byKey(const Key('error_message'));

      await tester.pumpWidget(makeTestableWidget(const SeasonDetailPage(
        argument: arguments,
      )));

      expect(textFinder, findsOneWidget);
    });
  });
}
