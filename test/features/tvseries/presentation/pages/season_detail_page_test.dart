import 'package:app_ditonton/common/state_enum.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/episode.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail.dart';
import 'package:app_ditonton/features/tvseries/domain/entities/season_detail_argument.dart';
import 'package:app_ditonton/features/tvseries/presentation/pages/season_detail_page.dart';
import 'package:app_ditonton/features/tvseries/presentation/provider/season_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart';

import 'season_detail_page_test.mocks.dart';

@GenerateMocks([SeasonDetailNotifier])
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

  const tId = 1;
  const arguments = SeasonDetailArgument(
    id: tId,
    season: Season(
      airDate: "2023-05-11",
      episodeCount: 1,
      id: tId,
      name: "name",
      overview: "overview",
      posterPath: "posterPath",
      seasonNumber: 1,
    ),
  );
  const episode = Episode(
    airDate: "2023-05-11",
    episodeNumber: 1,
    id: 1,
    name: "name",
    overview: "overview",
    runtime: 1,
    seasonNumber: 1,
    stillPath: "stillPath",
    voteAverage: 5,
    voteCount: 6,
  );
  const seasonDetail = SeasonDetail(
    id: 1,
    airDate: "2023-05-11",
    name: "name",
    overview: "overview",
    posterPath: "posterPath",
    seasonNumber: 1,
    episodes: <Episode>[episode, episode],
  );

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
      when(mockNotifier.seasonDetail).thenReturn(seasonDetail);

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
