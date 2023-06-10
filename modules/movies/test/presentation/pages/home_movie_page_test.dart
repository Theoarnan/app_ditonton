import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:movies/movies.dart';

import '../../test_helper/dummy_data.dart';
import '../../test_helper/test_helper_movies.dart';

void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MoviePopularBloc moviePopularBloc;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUpAll(() {
    // movie now playing
    movieNowPlayingBloc = MockMovieNowPlayingBloc();
    registerFallbackValue(MockMovieNowPlayingState());
    // movie popular
    moviePopularBloc = MockMoviePopularBloc();
    registerFallbackValue(MockMoviePopularState());
    // movie top rated
    movieTopRatedBloc = MockMovieTopRatedBloc();
    registerFallbackValue(MockMovieTopRatedState());
  });

  Widget makeTestableWidget(Widget body) {
    return MaterialApp(
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => movieNowPlayingBloc,
          ),
          BlocProvider(
            create: (_) => moviePopularBloc,
          ),
          BlocProvider(
            create: (_) => movieTopRatedBloc,
          ),
        ],
        child: body,
      ),
    );
  }

  group('Page home movies', () {
    testWidgets('should display center progress bar when loading', (
      WidgetTester tester,
    ) async {
      when(() => movieNowPlayingBloc.state).thenReturn(
        MoviesNowPlayingLoading(),
      );
      when(() => moviePopularBloc.state).thenReturn(MoviesPopularLoading());
      when(() => movieTopRatedBloc.state).thenReturn(MoviesTopRatedLoading());

      final centerNowPlayingFinder = find.byKey(
        const Key('loading_nowplaying'),
      );
      final progressBarNowPlayingFinder = find.byKey(
        const Key('circular_nowplaying'),
      );
      final centerPopularFinder = find.byKey(const Key('loading_popular'));
      final progressBarPopularFinder = find.byKey(
        const Key('circular_popular'),
      );
      final centerTopRatedFinder = find.byKey(const Key('loading_toprated'));
      final progressBarTopRatedFinder = find.byKey(
        const Key('circular_toprated'),
      );

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(centerNowPlayingFinder, findsOneWidget);
      expect(progressBarNowPlayingFinder, findsOneWidget);
      expect(centerPopularFinder, findsOneWidget);
      expect(progressBarPopularFinder, findsOneWidget);
      expect(centerTopRatedFinder, findsOneWidget);
      expect(progressBarTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display detail content when data is loaded',
        (WidgetTester tester) async {
      when(() => movieNowPlayingBloc.state).thenReturn(
        MovieNowPlayingHasData(tMovieList),
      );
      when(() => moviePopularBloc.state).thenReturn(
        MoviePopularHasData(tMovieList),
      );
      when(() => movieTopRatedBloc.state).thenReturn(
        MovieTopRatedHasData(tMovieList),
      );

      final listViewNowPlayingFinder = find.byKey(
        const Key('nowplaying'),
      );
      final listViewPopularFinder = find.byKey(
        const Key('popular'),
      );
      final listViewTopRatedFinder = find.byKey(
        const Key('toprated'),
      );

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(listViewNowPlayingFinder, findsOneWidget);
      expect(listViewPopularFinder, findsOneWidget);
      expect(listViewTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display text empty when state is empty',
        (WidgetTester tester) async {
      when(() => movieNowPlayingBloc.state).thenReturn(
        MoviesNowPlayingEmpty(),
      );
      when(() => moviePopularBloc.state).thenReturn(
        MoviesPopularEmpty(),
      );
      when(() => movieTopRatedBloc.state).thenReturn(
        MoviesTopRatedEmpty(),
      );

      final textEmptyKeyNowPlayingFinder = find.byKey(
        const Key('empty_text_nowplaying'),
      );
      final textEmptyNowPlayingFinder = find.text(
        '*Oops, data movies now playing is empty.',
      );
      final textEmptyKeyPopularFinder = find.byKey(
        const Key('empty_text_popular'),
      );
      final textEmptyPopularFinder = find.text(
        '*Oops, data popular movies is empty.',
      );
      final textEmptyKeyTopRatedFinder = find.byKey(
        const Key('empty_text_toprated'),
      );
      final textEmptyTopRatedFinder = find.text(
        '*Oops, data top rated movies is empty.',
      );

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(textEmptyKeyNowPlayingFinder, findsOneWidget);
      expect(textEmptyNowPlayingFinder, findsOneWidget);
      expect(textEmptyKeyPopularFinder, findsOneWidget);
      expect(textEmptyPopularFinder, findsOneWidget);
      expect(textEmptyKeyTopRatedFinder, findsOneWidget);
      expect(textEmptyTopRatedFinder, findsOneWidget);
    });

    testWidgets('should display text with message when Error',
        (WidgetTester tester) async {
      when(() => movieNowPlayingBloc.state).thenReturn(
        const MoviesNowPlayingError('Error Message'),
      );
      when(() => moviePopularBloc.state).thenReturn(
        const MoviesPopularError('Error Message'),
      );
      when(() => movieTopRatedBloc.state).thenReturn(
        const MoviesTopRatedError('Error Message'),
      );

      final textNowPlayingFinder = find.byKey(
        const Key('error_message_nowplaying'),
      );
      final textPopularFinder = find.byKey(
        const Key('error_message_popular'),
      );
      final textTopRatedFinder = find.byKey(
        const Key('error_message_toprated'),
      );

      await tester.pumpWidget(makeTestableWidget(const HomeMoviePage()));

      expect(textNowPlayingFinder, findsOneWidget);
      expect(textPopularFinder, findsOneWidget);
      expect(textTopRatedFinder, findsOneWidget);
    });
  });
}
